----------------------------------------------------------------------------
--Dynamic Proto-object-based Visual Saliency Model MATLAB Code
--version 1.0, 4 May, 2017, Jamal Molin
--
--Copyright (c) 2015-2016, Trustees of Johns Hopkins University
--All rights reserved.
--
--Redistribution and use in source and binary forms, with or without
--modification is only permitted provided the following conditions are met:

--Redistributions of source code must retain the above copyright notice, 
--this list of conditions and the following disclaimer.
--Redistributions in binary form must reproduce the above copyright notice,
--this list of conditions and the following disclaimer in the documentation
--and/or other materials provided with the distribution.
--
--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
--"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
--TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
--PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
--CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
--EXEMPLARY, OR CONSEQUENTIAL DAMAGES(INCLUDING, BUT NOT LIMITED TO,
--PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
--PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
--LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
--NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
----------------------------------------------------------------------------

To run model with motion:

1) Load in video data into matlab.  Must be:
	
	- 4 Dimensions (num rows x num columns x 3 (RGB) x num frames)
	- Type 'double'

2) Run:
	
sal_map = runProtoSalDynamic(vid)


3) Output is a struct containing the dynamic saliency map (num rows x num cols x num_frames) and also contains
   the individual conscipuity map for the 3 different channels (num rowx x num cols x num frames x 3)

    Channel 1 - intensity
    Channel 2 - color
    Channel 3 - orientation

For example, run:

run_example.m

This will run vid_leopard.  To run on only a small number of frames, change the
num_frames_to_run variable within "run_example.m" to a smaller number of frames.
Content-Type: multipart/mixed; boundary="===============0850576256095668938=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Wed, 02 Oct 2019 17:39:10 -0700
Message-ID: <alpine.OSX.2.21.1910021737190.33041@syitbare-mobl.amr.corp.intel.com>
In-Reply-To: alpine.OSX.2.21.1910021653250.33041@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2006

--===============0850576256095668938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 2 Oct 2019, Mat Martineau wrote:

> On Wed, 2 Oct 2019, Mat Martineau wrote:
>
>> =

>> On Wed, 2 Oct 2019, Matthieu Baerts wrote:
>> =

>>> On my side, I think our last "export" branch is ready: all the patches
>>> we previously mentioned are merged, it is rebased on latest net-next,
>>> tests are all good. I think it is ready to be sent! I just tagged
>>> netdev-rfcv2 but feel free to modify it if it is not OK :)
>>> =

>>> With a bit of luck, if you have time to send it and if nothing is
>>> missing, we might have the first feedbacks before the meeting tomorrow!
>>> Or yeah, more likely for the week after. But we never know :)
>> =

>> =

>> I just sent the 45 (!) patch series to netdev. Thanks for all of your wo=
rk =

>> to prepare the branch, Matthieu.
>> =

>> I will also push the branch to my git.kernel.org repo to trigger a =

>> LKP/0-day automated build.
>> =

>
> ...and I just figured out that I generated the .patch files from the wron=
g =

> commits :(
>
> Regenerating those and resending. Sorry!
>

Based on Dave's feedback, it looked like a bad idea to repost the correct =

43 patches today. Sorry again about the error on my part, we can discuss =

how to partition the patch series (and possibly squash some more patches) =

at the meeting tomorrow.

--
Mat Martineau
Intel
--===============0850576256095668938==--

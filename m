Content-Type: multipart/mixed; boundary="===============3102982438987300482=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squashto: mptcp: schedule worker when subflow is
 closed
Date: Wed, 10 Feb 2021 10:03:38 -0800
Message-ID: <3d8abe11-5695-d263-14aa-bcf1dec517ec@linux.intel.com>
In-Reply-To: 02ea6762-b88f-60ee-356f-40358d31818d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7751

--===============3102982438987300482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Feb 2021, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 10/02/2021 17:04, Paolo Abeni wrote:
>> On Wed, 2021-02-10 at 13:47 +0100, Florian Westphal wrote:
>>> When remote side closes a subflow we should schedule the worker to
>>> dispose of the subflow in a timely manner.
>>> =

>>> Otherwise, SF_CLOSED event won't be generated until the mptcp
>>> socket itself is closing or local side is closing another subflow.
>>> =

>>> As noted by Paolo and Matthieu, a subflow that moves to TCP_CLOSE state
>>> might still have data in its rx queue.
>
> (...)
>
>> =

>> LGTM!
>> =

>> @Matttbe: could you please double check this one vs issues/154?
>
> Sure! I should have commented here instead of on GH :)
> I ran this for more than 3h now and I was not able to reproduce this issu=
e! I =

> just stopped the loop.
>
> It looks good to me but I prefer to wait for Mat's ACK as he was the revi=
ewer =

> of the original patch. I can always remove his RvB tag and re-add it late=
r if =

> needed.
>
> Thanks for your work!
>

Ack from me as well - please squash and keep the RvB!


--
Mat Martineau
Intel
--===============3102982438987300482==--

Content-Type: multipart/mixed; boundary="===============8527250105946168662=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squashto: mptcp: schedule worker when subflow is
 closed
Date: Wed, 10 Feb 2021 17:11:10 +0100
Message-ID: <02ea6762-b88f-60ee-356f-40358d31818d@tessares.net>
In-Reply-To: 07bff2df68ce5037b63f618b508cb0a030fd21ad.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7749

--===============8527250105946168662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 10/02/2021 17:04, Paolo Abeni wrote:
> On Wed, 2021-02-10 at 13:47 +0100, Florian Westphal wrote:
>> When remote side closes a subflow we should schedule the worker to
>> dispose of the subflow in a timely manner.
>>
>> Otherwise, SF_CLOSED event won't be generated until the mptcp
>> socket itself is closing or local side is closing another subflow.
>>
>> As noted by Paolo and Matthieu, a subflow that moves to TCP_CLOSE state
>> might still have data in its rx queue.

(...)

> =

> LGTM!
> =

> @Matttbe: could you please double check this one vs issues/154?

Sure! I should have commented here instead of on GH :)
I ran this for more than 3h now and I was not able to reproduce this =

issue! I just stopped the loop.

It looks good to me but I prefer to wait for Mat's ACK as he was the =

reviewer of the original patch. I can always remove his RvB tag and =

re-add it later if needed.

Thanks for your work!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8527250105946168662==--

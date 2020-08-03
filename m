Content-Type: multipart/mixed; boundary="===============6033285876800572905=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix bogus sendmsg() return code under
 pressure
Date: Mon, 03 Aug 2020 18:14:45 +0200
Message-ID: <6a63ce16-0fe3-e0a2-e7b5-0878572abda6@tessares.net>
In-Reply-To: 6673051c-6e55-5a2d-6f83-4fb9ea026634@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5445

--===============6033285876800572905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 03/08/2020 17:30, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 31/07/2020 18:53, Paolo Abeni wrote:
>> In case of memory pressure, mptcp_sendmsg() may call
>> sk_stream_wait_memory() after succesfully xmitting some
>> bytes. If the latter fails we currently return to the
>> user-space the error code, ignoring the succeful xmit.
>>
>> Address the issue always checking for the xmitted bytes
>> before mptcp_sendmsg() completes.
> =

> Thank you for the patch! It looks good to me!
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

The commit is now in the "export" branch and validated by the CI. The =

results are the same as before your commit: the same 2 tests are failing =

(diag.sh and packetdrill's dss tests as described on GitHub).

Then please go ahead by sending this patch to -net! :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6033285876800572905==--

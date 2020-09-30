Content-Type: multipart/mixed; boundary="===============3199623522083987178=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH net 1/2] mptcp: Consistently use
 READ_ONCE/WRITE_ONCE with msk->ack_seq
Date: Wed, 30 Sep 2020 12:31:44 +0200
Message-ID: <d0d6b8d0-16b2-d677-215d-6e7d4947afac@tessares.net>
In-Reply-To: 302cc293-21ff-3263-8945-c60e6c1b5c3f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6114

--===============3199623522083987178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 30/09/2020 12:19, Matthieu Baerts wrote:
> Hi Mat,
> =

> On 26/09/2020 02:24, Mat Martineau wrote:
>> The msk->ack_seq value is sometimes read without the msk lock held, so
>> make proper use of READ_ONCE and WRITE_ONCE.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>
>> This does create some merge conflicts with net-next - what's the best
>> way to handle that?
> =

> Should we send to netdev ML about how we resolve the conflicts?

(...)

> Patch 2:
> - subflow.c: we don't use the returned value of =

> mptcp_update_rcv_data_fin() in net-next

I just noticed your commit ef59b1953c26 ("mptcp: Wake up MPTCP worker =

when DATA_FIN found on a TCP FIN packet") is not on net-next yet.

So we do use the returned value if I put your two new patches on top of =

ef59b1953c26!

The "export" branch is going to be updated soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3199623522083987178==--

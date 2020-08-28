Content-Type: multipart/mixed; boundary="===============8797052238984313015=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3] mptcp: adjust mptcp receive buffer
 limit if subflow has larger one
Date: Fri, 28 Aug 2020 21:15:00 +0200
Message-ID: <96a4b355-0781-c534-5e3b-7d1c676dbeff@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2008201725250.59053@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 5659

--===============8797052238984313015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 21/08/2020 02:25, Mat Martineau wrote:
> =

> On Thu, 20 Aug 2020, Florian Westphal wrote:
> =

>> In addition to tcp autotuning during read, it may also increase the
>> receive buffer in tcp_clamp_window().
>>
>> In this case, mptcp should adjust its receive buffer size as well so
>> it can move all pending skbs from the subflow socket to the mptcp socket.
>>
>> At this time, TCP can have more skbs ready for processing than what the
>> mptcp receive buffer size allows.
>>
>> In the mptcp case, the receive window announced is based on the free
>> space of the mptcp parent socket instead of the individual subflows.
>>
>> Following the subflow allows mptcp to grow its receive buffer.
>>
>> This is especially noticeable for loopback traffic where two skbs are
>> enough to fill the initial receive window.
>>
>> In mptcp_data_ready() we do not hold the mptcp socket lock, so modifying
>> mptcp_sk->sk_rcvbuf is racy.=C2=A0 Do it when moving skbs from subflow to
>> mptcp socket, both sockets are locked in this case.
>>
>> v2: move rcvbuf update to __mptcp_move_skbs_from_subflow where both
>> mptcp and subflow sk locks are held (pointed out by Mat Martineau).
>> v3: only adjust if receive buffer size isn't fixed. (Mat Martineau).
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
> =

> Looks good to me.=C2=A0 Thanks Florian.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the patch and the review!

Applied at the end of the series.

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8797052238984313015==--

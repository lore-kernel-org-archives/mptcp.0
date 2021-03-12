Content-Type: multipart/mixed; boundary="===============3478226787493752527=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][bug report] bpf test error: Attempt to release
 TCP socket in state 8
Date: Fri, 12 Mar 2021 15:03:12 +0100
Message-ID: <c905463d-e5fa-88ab-2f82-4aaecceeda8b@tessares.net>
In-Reply-To: CA+WQbwtmg2=fymqK=v7U3UQRF4sTjTRAfbHf-PREWf9tiLRcOw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8114

--===============3478226787493752527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 11/03/2021 12:48, Geliang Tang wrote:
> Hi Matt,
> =

> When I ran the bpf mptcp test "sudo ./test_progs -n 66", I got another
> error in kernel log:

(...)

> It seems that the mptcp socket isn't closed properly.

I'm not sure what's wrong. I didn't write the test program but from what =

I see, we are only reading info from BPF, we don't modify behaviours =

using BPF.

Or at least, not directly. Maybe the test environment is using BPF for =

other tasks and this is not supported with an MPTCP socket. Something is =

maybe missing on our side.

Is the test succeeding? Maybe this message was there from the beginning, =

I could not tell.

I'm sorry not to be able to help more.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3478226787493752527==--

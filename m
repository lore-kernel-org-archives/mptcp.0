Content-Type: multipart/mixed; boundary="===============3257483362810114036=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/2] mptcp: add receive buffer auto-tuning
Date: Wed, 01 Jul 2020 17:48:11 -0700
Message-ID: <20200701.174811.1709600582793325645.davem@davemloft.net>
In-Reply-To: 20200630192445.18333-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4891

--===============3257483362810114036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>
Date: Tue, 30 Jun 2020 21:24:43 +0200

> First patch extends the test script to allow for reproducible results.
> Second patch adds receive auto-tuning.  Its based on what TCP is doing,
> only difference is that we use the largest RTT of any of the subflows
> and that we will update all subflows with the new value.
> =

> Else, we get spurious packet drops because the mptcp work queue might
> not be able to move packets from subflow socket to master socket
> fast enough.  Without the adjustment, TCP may drop the packets because
> the subflow socket is over its rcvbuffer limit.

Series applied, thanks Florian.
--===============3257483362810114036==--

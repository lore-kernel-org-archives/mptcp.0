Content-Type: multipart/mixed; boundary="===============7208954351857281791=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: don't skip needed ack
Date: Tue, 06 Oct 2020 06:08:25 -0700
Message-ID: <20201006.060825.725318051868237498.davem@davemloft.net>
In-Reply-To: 515e80a174ee9bad5e2c6a8338d9362eb43d39b7.1601894086.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6220

--===============7208954351857281791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Mon,  5 Oct 2020 12:36:44 +0200

> Currently we skip calling tcp_cleanup_rbuf() when packets
> are moved into the OoO queue or simply dropped. In both
> cases we still increment tp->copied_seq, and we should
> ask the TCP stack to check for ack.
> =

> Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied.
--===============7208954351857281791==--

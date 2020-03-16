Content-Type: multipart/mixed; boundary="===============6973307556756982183=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Mon, 16 Mar 2020 19:06:13 +0100
Message-ID: <2966ece542d3bc3ec5e904f137890ca09d6578ad.camel@redhat.com>
In-Reply-To: cover.1584370791.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3956

--===============6973307556756982183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-16 at 16:09 +0100, Paolo Abeni wrote:
> This series addresses the currently known issues in MP_JOIN self-tests.
> =

> Due to some races, without these patches I observe intermittent failures =
(say
> 1 out of 3 self-tests fail). With this patches applied, self-tests surviv=
ed
> ~200 iterations successfully.
> =

> See individual patches for the details.
> =

> On top of "mptcp: move msk state update to subflow_syn_recv_sock()"

Just for reference, the current export branch
(@1016c1ca454a2f19075f1d0c4925c35f698b6f8c) + "mptcp: move msk state
update to subflow_syn_recv_sock()" + these patches is available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_10

/P

--===============6973307556756982183==--

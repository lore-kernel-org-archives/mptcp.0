Content-Type: multipart/mixed; boundary="===============8193285232308635411=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix DSS map generation on fin
 retransmission
Date: Tue, 07 Jul 2020 15:28:21 -0700
Message-ID: <20200707.152821.167533135677461439.davem@davemloft.net>
In-Reply-To: 1fa7663816c25b247db50501cf3d9df01729dc28.1593792286.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4940

--===============8193285232308635411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri,  3 Jul 2020 18:06:04 +0200

> The RFC 8684 mandates that no-data DATA FIN packets should carry
> a DSS with 0 sequence number and data len equal to 1. Currently,
> on FIN retransmission we re-use the existing mapping; if the previous
> fin transmission was part of a partially acked data packet, we could
> end-up writing in the egress packet a non-compliant DSS.
> =

> The above will be detected by a "Bad mapping" warning on the receiver
> side.
> =

> This change addresses the issue explicitly checking for 0 len packet
> when adding the DATA_FIN option.
> =

> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data pac=
kets")
> Reported-by: syzbot+42a07faa5923cfaeb9c9(a)syzkaller.appspotmail.com
> Tested-by: Christoph Paasch <cpaasch(a)apple.com>
> Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied and queued up for -stable, thank you.
--===============8193285232308635411==--

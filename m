Content-Type: multipart/mixed; boundary="===============1172552061894753453=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 01/13] tcp: factor out tcp_build_frag()
Date: Thu, 12 Nov 2020 15:08:31 -0800
Message-ID: <20201112150831.1c4bb8b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 8fcb0ad6f324008ccadfd1811d91b3145bbf95fd.1605199807.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6706

--===============1172552061894753453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2020 18:45:21 +0100 Paolo Abeni wrote:
> +		skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
> +				tcp_rtx_and_write_queues_empty(sk));

no good reason to misalign this AFAICT
--===============1172552061894753453==--

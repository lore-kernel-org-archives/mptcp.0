Content-Type: multipart/mixed; boundary="===============5548548083898860137=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Wed, 09 Dec 2020 16:25:33 +0100
Message-ID: <4a386ae2d2fe8c537be71ffa1f795e96de4b3b7f.camel@redhat.com>
In-Reply-To: 20201209123310.GA3675@MiBook
X-Status: 
X-Keywords:                  
X-UID: 7103

--===============5548548083898860137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-12-09 at 20:33 +0800, Geliang Tang wrote:
> The full log and the patch is attached. Apply this patch and run
> mptcp_join.sh can reproduce the warning.

I tried applying the v7 posted on the ML, plus some manging to let it
apply on top of current export. The end result is quite alike the patch
attached here.

Still I can't reproduce the issue.

I'm wondering if the kconfig matters here (beyond CONFIG_LOCKDEP=3Dy, I
mean). Could you please share the config you are using ?

Thanks!

Paolo

--===============5548548083898860137==--

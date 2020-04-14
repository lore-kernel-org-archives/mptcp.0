Content-Type: multipart/mixed; boundary="===============8024523228306047304=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] add support for mptcp netlink interface.
Date: Tue, 14 Apr 2020 17:51:12 +0200
Message-ID: <9f245027f7a3480e83b478fdc0cb6f4b9793bdde.camel@redhat.com>
In-Reply-To: 903499dbff51b14cf126914794854c337ed98dac.1586444916.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4165

--===============8024523228306047304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-04-14 at 10:24 +0200, Paolo Abeni wrote:
>                argc--, argv++;

nit: why not doing NEXT_ARG_FWD()  here?

-- =

davide

--===============8024523228306047304==--

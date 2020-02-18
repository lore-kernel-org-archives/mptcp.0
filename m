Content-Type: multipart/mixed; boundary="===============0212946345478287209=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 7/7] selftests: add PM netlink functional tests
Date: Tue, 18 Feb 2020 11:27:03 +0100
Message-ID: <56dd3428413f95140093abd99d068fda75bd43ec.camel@redhat.com>
In-Reply-To: 6e6bf9803a683ffd84daee3ed8db3941831546a6.1581963739.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3690

--===============0212946345478287209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 19:28 +0100, Paolo Abeni wrote:
> +CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g  -iquote../../../../../inclu=
de/uapi/

hello Paolo,

nit: what about using KSFT_KHDR_INSTALL ? =

-- =


davide


--===============0212946345478287209==--

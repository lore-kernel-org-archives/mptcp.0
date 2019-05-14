Content-Type: multipart/mixed; boundary="===============1838222405343056342=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC mptcp 2/2] mptcp: allow dumping subflow
 context to userspace
Date: Tue, 14 May 2019 11:34:32 +0200
Message-ID: <071168da3f5216a3a7729e69a34e29a43d9e89cb.camel@redhat.com>
In-Reply-To: 44355666d00f9f993af834352c5ada97d1748783.1557824658.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1162

--===============1838222405343056342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-05-14 at 11:14 +0200, Davide Caratti wrote:
>      - this is a POC patch where I only dump few members of the subflow, =
and
>        put them in a nested attribute so that it's possible to read them =
in
>        a program regardless the value of 'subflow_ulp_ops.name'. Please l=
et
>        me know if we should dump additional information, or if some of th=
ose
>        I included don't make sense.

I personally think that SSN and mapping related info would be useful
and worthy to add.

Paolo



--===============1838222405343056342==--

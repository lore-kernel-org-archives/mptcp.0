Content-Type: multipart/mixed; boundary="===============0289600747255740908=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] mptcp: allow dumping subflow context to
 userspace
Date: Thu, 12 Sep 2019 18:57:53 +0200
Message-ID: <c2abb5d4494fb687eb394f7e5b90c35ee01060e2.camel@redhat.com>
In-Reply-To: d9b73a7a7065931e920f0c0df3012209a8448f60.1568307013.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1829

--===============0289600747255740908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-12 at 18:50 +0200, Davide Caratti wrote:
> add ulp-specific diagnostic functions, so that subflow information can be
> dumped to userspace programs like 'ss'.

for the record: iproute2 support is also on the way, but also in this case
the first step will be in ktls. This patch exposes token, local/remote
keys, and some of the bitfield members. What do you think it's reasonable
exposing to users of 'ss -i' ?

any feedback welcome.
thanks,
-- =

davide



--===============0289600747255740908==--

Content-Type: multipart/mixed; boundary="===============1580767257728246736=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] ss: allow dumping MPTCP subflow information
Date: Mon, 20 Apr 2020 19:10:59 +0200
Message-ID: <2dd91483e09dc0a829928e8f5f6dc23f778d053e.camel@redhat.com>
In-Reply-To: c07afd2b-017e-4e04-3b5c-3de0378c395a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4208

--===============1580767257728246736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-04-20 at 18:47 +0200, Matthieu Baerts wrote:
> Do you think we can also add what each of "MmBbJjecv" means? :-)

... sure, even if it's painful as we are already in a .TP item :) I'm more
worried about what to write as understandable description for 'sfseq'
'ssn_offset', and 'map_valid'.

Can we do this in a separate patch, if it doesn't block the acceptance of
'iproute2' series?
-- =

davide =20

--===============1580767257728246736==--

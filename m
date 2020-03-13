Content-Type: multipart/mixed; boundary="===============3144252017098389907=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] Sync with net-next on 20200313: conflicts
Date: Fri, 13 Mar 2020 18:50:44 +0100
Message-ID: <57a8012989fdd2932b75a41a91b8fbd6da909687.camel@redhat.com>
In-Reply-To: f106be37-1a94-25ef-02f0-83e1eaf3c222@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3941

--===============3144252017098389907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-13 at 18:46 +0100, Matthieu Baerts wrote:
> Hello,
> =

> Recently, one MPTCP-related patch from Davide has been applied in =

> 'net-next' repo:
> =

> - 767d3ded5fb8 (net: mptcp: don't hang before sending 'MP capable with =

> data')
> =

> This created conflicts:
> =

> - 21a8666f4683: conflict in t/mptcp-Add-path-manager-interface
> - c1aa2cd27a83: conflict in =

> t/mptcp-update-per-unacked-sequence-on-pkt-reception
> =

> I hope they have been resolved as expected.
> =

> Tests are all green and the "export" branch has been updated.

Yep, conflicts resolution LGTM.

Thanks,

Paolo

--===============3144252017098389907==--

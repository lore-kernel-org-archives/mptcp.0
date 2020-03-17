Content-Type: multipart/mixed; boundary="===============6296233268709127497=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v5 0/5] Add support for v1 of ADD_ADDR option
Date: Tue, 17 Mar 2020 13:16:12 +0100
Message-ID: <b1ed1f0eead33327bbd5dd0bb9cb70553af145ac.camel@redhat.com>
In-Reply-To: 20200316183911.4347-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3965

--===============6296233268709127497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-16 at 11:39 -0700, Peter Krystad wrote:
> Support parsing and writing the new option format, with hmac generation
> and validation.
> =

> Support for echoing ADD_ADDR still to come.
> =

> v2: check msg len in mptcp_crypto_hmac_sha().
>     remove obsolete casts
> v3: Rebase and split for squashing, patches ready to be applied.
> v4: Get the first two patches of the set right
> v5: plug hole in mptcp_options_received
> =

> Peter Krystad (5):
>   mptcp: Re-factor mptcp_crypto_hmac_sha()
>   mptcp: v1 ADD_ADDR changes: options and parsing
>   mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
>   mptcp: v1 ADD_ADDR changes: add subflow_generate_hmac()
>   mptcp: v1 ADD_ADDR changes: use subflow_generate_hmac()

LGMT, thanks Peter!

/P

--===============6296233268709127497==--

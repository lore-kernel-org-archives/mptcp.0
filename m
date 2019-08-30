Content-Type: multipart/mixed; boundary="===============7919235672037531072=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix mptcp socket cleanup
Date: Fri, 30 Aug 2019 14:29:21 +0200
Message-ID: <20190830122921.GP20113@breakpoint.cc>
In-Reply-To: e88e1256082439491fbfb0b92e254a692b32af7f.1567167420.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1768

--===============7919235672037531072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> +		/* when assiging the token to the msk, we need to held
> +		 * an additional reference, will be released at msk token
> +		 * destruction time
> +		 */

Unrelated to your patch, but I think this is wrong.
We should have implicit reference for the token.

Taking a reference makes no sense because the token lifetime is limited by
the mptcp socket -- if the mptcp socket is closing, we remove the token too.

token_release() function makes no sense to me -- afaics all callers
have a pointer to the msk they want to put the reference for.

I'll have a look into cleaning that up after respinning a squashable
version of the token refactoring.

--===============7919235672037531072==--

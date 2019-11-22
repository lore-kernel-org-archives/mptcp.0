Content-Type: multipart/mixed; boundary="===============7494137725581811063=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] crypto: refactor sha code
Date: Fri, 22 Nov 2019 15:30:42 +0100
Message-ID: <34a3db383cb02ac6a81a1edb2afde5f432f18651.camel@redhat.com>
In-Reply-To: cover.1574432261.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2665

--===============7494137725581811063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-11-22 at 15:26 +0100, Paolo Abeni wrote:
> patch 1/4 refactor the crypto code to make it easier transitioning to
> sha256. It includes feedback from Peter about helper renaming.
> =

> The following patches update the rest of the tree to the new helper name.
> Overall this should generate 3 conflicts along the rebase.

Addendum:

The squashed tree is avaialble here:

https://github.com/pabeni/mptcp/tree/sha_cleanup_2

I verified the new code ensuring that the genrated seq number matched
the expectation of the wireshark dissector.

Cheers,

Paolo

--===============7494137725581811063==--

Content-Type: multipart/mixed; boundary="===============1979242338398948345=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/9] token: handle join-before-accept-completion
 case
Date: Mon, 02 Dec 2019 14:31:37 +0100
Message-ID: <20191202133137.GN795@breakpoint.cc>
In-Reply-To: fb50431e6af8c7dd09131420268068fa48b6882f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2739

--===============1979242338398948345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Note, with MPTCP v1, we will probably have to add additional checks
> here (e.g. con->fourth_ack must be true). Perhaps we can add that
> already?

I'm not sure this is the right location.  Should that check not
be done where we add the ssk to the conn_list?
--===============1979242338398948345==--

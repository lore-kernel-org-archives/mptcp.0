Content-Type: multipart/mixed; boundary="===============2993274021367449360=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use mptcp worker for path
 management
Date: Mon, 22 Jun 2020 13:18:17 +0200
Message-ID: <20200622111817.GP26990@breakpoint.cc>
In-Reply-To: b512db36ca6823b3108e11073376bcddad4d6648.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4764

--===============2993274021367449360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> I'm wondering if we should keep using an MPTCP-specific workqueue.
> Server side, we don't expect the work to trigger very often, but should
> that ever happen, top will tell easily.

You mean switch msk->work from system_wq to a custom workqueue?
--===============2993274021367449360==--

Content-Type: multipart/mixed; boundary="===============7461200699643122926=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Wed, 11 Dec 2019 20:22:09 +0100
Message-ID: <20191211192209.GM795@breakpoint.cc>
In-Reply-To: afc3068e9c228b78ab384be40da1152ba5bfc6a0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2874

--===============7461200699643122926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> @Florian: I tested the whole tree vs self-tests - so MP_JOIN is not
> really tested. Are you ok to merge as-is and then look after eventual
> bug introduced by me here?

Maybe, can you explain __mptcp_flush_join_list() usage?

AFAICS subflow on join list can be moved to conn_list at 'random'
point in time, even if its not fully established yet?

(there are calls to __mptcp_flush_join_list in recv/sendmsg path...)

Given MP_JOIN isn't in the 1st/2nd batch i would be ok with merging
now though.
--===============7461200699643122926==--

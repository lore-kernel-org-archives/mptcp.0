Content-Type: multipart/mixed; boundary="===============2171512469746484921=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/3] mptcp: ip option handling demo patch
Date: Thu, 05 Mar 2020 14:22:28 +0100
Message-ID: <20200305132231.22953-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3869

--===============2171512469746484921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds infra to handle ip options and propagate them from
the mptcp socket to the subflow sockets, and vice versa.

Given there are IP options that are subflow specific, I am not
convinced this is a good idea to begin with, we might need an
API that exposes the individual subflows.

I don't plan to continue working on this; this is just so things
get archived and we can revisit this later when needed.



--===============2171512469746484921==--

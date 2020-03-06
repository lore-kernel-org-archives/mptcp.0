Content-Type: multipart/mixed; boundary="===============7255847365786110467=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: create msk early
Date: Thu, 05 Mar 2020 17:31:49 -0800
Message-ID: <alpine.OSX.2.22.394.2003051724120.45396@mlee22-mobl.amr.corp.intel.com>
In-Reply-To: ed7a14f7a0aa42acf8ef0a29fc966787fadd78f5.1583435184.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3887

--===============7255847365786110467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 5 Mar 2020, Paolo Abeni wrote:

> This closes a race between MPC subflow accept and additional MPJ
> creation which leads to MPJ subflow being dropped with
> MPTCP_MIB_JOINNOTOKEN despite carrying the correct token.
> (also fixes some sporadic self-tests failures)
>
> It also makes accept faster, as we only take a single spinlock
> vs a spinlock and 2 socket locks.

The locking simplification is a nice side benefit.

>
> Additional clean-up could be added in several places where we
> currently check for subflow->conn -> after this patch we know
> it's always valid.
>
> Flip side: more memory allocated for the accept backlog.
> I personally think that is acceptable -> we already allocate
> more memory on the server.

Since the subflow is already allocating resources at this stage of the =

connection, it seems fine to do the same for the msk too. Seems like a =

good change to make.

>
> Sharing as an early RFC to gather comments.

--
Mat Martineau
Intel
--===============7255847365786110467==--

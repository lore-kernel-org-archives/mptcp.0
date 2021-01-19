Content-Type: multipart/mixed; boundary="===============8030100681725116881=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash-to: "mptcp: implement delegated
 actions"
Date: Tue, 19 Jan 2021 13:28:35 +0100
Message-ID: <3bd23549d680edcf102f3b3a45e0c3ff0abb051f.camel@redhat.com>
In-Reply-To: c71bfc25db341e5cde87059b94b82cf92462fbac.1611058499.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7423

--===============8030100681725116881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-01-19 at 13:15 +0100, Paolo Abeni wrote:
> Many issues in the reference patch:
> =

> - mptcp_subflow_has_delegated_action() tested the wrong condition,
> fix it - things did not break hard too much, because usually
> mptcp_napi_poll() kicked in and processed the pending action
> without any sanity check
> =

> - subflow->delegated_node/mptcp_delegated_action->head is
> touched/modified by the subflow release callback, which is
> helding the local BH, but can run on a CPU other then the
> one that originally scheduled the delegated action. That
> would cause list corruption. Clarify the locking schema in
> the header file and touch the node only in mptcp_delegated_action
> poll, which is always running on the relevant CPU (unless
> the whole net is broken hard [which is currently apparently
> the case]).

This is still buggy, it will need a v2. Sorry for the noise.

/P

--===============8030100681725116881==--

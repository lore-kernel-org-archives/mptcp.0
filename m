Content-Type: multipart/mixed; boundary="===============5937350749739764208=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] Squash-to: "mptcp: implement
 delegated actions"
Date: Tue, 19 Jan 2021 18:38:02 +0100
Message-ID: <4ab34bdf-5bb1-f2bd-5f4e-b91e55732930@tessares.net>
In-Reply-To: 677811d751738e2a4329a6b15e78a5a76598c489.1611071647.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7426

--===============5937350749739764208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 19/01/2021 16:54, Paolo Abeni wrote:
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
> the header file and touch the node only in mptcp_napi_poll()
> /mptcp_subflow_delegated_next(), which is always running on
> the relevant CPU.
> =

> As a consequence we must check mptcp_subflow_has_delegated_action()
> in mptcp_napi_poll(), too (release_cb could have already served the
> action, but the subflow would still be enqueued)
> =

> - when delegating the action we need to acquire an extra reference
> to the delegated subflow, otherwise such socket could be disposed
> in-between the scheduling and the mptcp_napi_poll() call itself.
> (actually I'm not 130% sure that could really happen due to the
> non trivial chain of references between the ssk, the msk the other ssk,
> but better safe than sorry).
> =

> - we can drop an unneeded local bh disable/enable pair, since
> mptcp_subflow_delegate() is always called from bh. Add a suitable
> lockdep annotation istead.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thanks for the new version and the review (on IRC).

- 870abbfb3a63: "squashed" in "mptcp: implement delegated actions"
- Results: 937c6b353409..179a95c1159f

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5937350749739764208==--

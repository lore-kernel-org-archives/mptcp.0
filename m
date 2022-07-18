Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CAEA6
	for <mptcp@lists.linux.dev>; Mon, 18 Jul 2022 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658135867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bbmb2Omjo8fqDWpLbyLG/T3zXbtL5pJXUUlC3aBP6gg=;
	b=bDGPJOr8RSEes3IsuTQBOw6paZDbb5WtRmtAZJ9xnl1Mj/CkhDvH71hzhdFwsU9ovK+EyL
	ZxO4uEJV6O0s97IcsZHMXD6GQDwxkvj6TZNBfP0jlvv/bw37+IZFOHLb5OWacDOezQQtCj
	iCHbf+ysYSNOLiZ7qpSTVTBZJdcOCVg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-3OGPk-2VM-OXZV6fK_QHYw-1; Mon, 18 Jul 2022 05:17:45 -0400
X-MC-Unique: 3OGPk-2VM-OXZV6fK_QHYw-1
Received: by mail-qk1-f197.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so8933193qkb.9
        for <mptcp@lists.linux.dev>; Mon, 18 Jul 2022 02:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Bbmb2Omjo8fqDWpLbyLG/T3zXbtL5pJXUUlC3aBP6gg=;
        b=XMoP9HC07BY1CbkVjEF7ttRsjyy6C5FRkc5NBrCXqM2GC+Xevy6k5yuCsN6a0sN1pb
         TP23FFpWWuluSCdavor0kmcMU4MEmlllvxYB5zQn0/7wqFaNPeX6ePZZKEaVsBDe4q76
         0Zyb83qJDsQVWY+BCNVyskmZR/D8sz5wAO9I++eQ+6O6/ehpxj4jacq02u1p7+WjXcT6
         b3t7C2pOOz5g5d/xkWFQD1rnOoYtJgIMGoetguiE12zP63R9m+QG8iw+s3wRMk6N2Hj5
         wkMsSshSBBQ44Kh/1VvXtXt/jgVjk93UD9PkiWetrOHvhcmlOJhPzEfjOeANoOMHhJZQ
         YNeA==
X-Gm-Message-State: AJIora+kvPD6poPutEfDIoc2nDz3srPSPhOzQ1kUwUwHGB7QbbgAqL99
	pbPb2fGWAZGarZPGG+EIdSGTMg4UuRkKTlmpqO5KbCET+1l9w1sHSJyiNdf5fiYH1njHGIWEocp
	QotZ3MrG1yYdaahY=
X-Received: by 2002:a05:622a:13:b0:317:9bb2:b0ae with SMTP id x19-20020a05622a001300b003179bb2b0aemr20349791qtw.411.1658135865130;
        Mon, 18 Jul 2022 02:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4XdHSLpwHiSmGwCRjwq9r2rUnDNMtZgW2CH7FICtcPFgdfZYt+971dp2MZtGK2KXwbrhP1Q==
X-Received: by 2002:a05:622a:13:b0:317:9bb2:b0ae with SMTP id x19-20020a05622a001300b003179bb2b0aemr20349779qtw.411.1658135864847;
        Mon, 18 Jul 2022 02:17:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-238.dyn.eolo.it. [146.241.97.238])
        by smtp.gmail.com with ESMTPSA id fz26-20020a05622a5a9a00b0031ef366c9b5sm1114722qtb.34.2022.07.18.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:17:44 -0700 (PDT)
Message-ID: <64bcf034cea0d8f4e19c8d2c8cd289ed0ccd6cb0.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: move subflow cleanup in
 mptcp_destroy_common()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, phind.uet@gmail.com
Date: Mon, 18 Jul 2022 11:17:41 +0200
In-Reply-To: <3e824615-67a2-77c5-6752-572fb17a71d5@linux.intel.com>
References: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>
	 <3e824615-67a2-77c5-6752-572fb17a71d5@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-07-15 at 12:13 -0700, Mat Martineau wrote:
> On Fri, 15 Jul 2022, Paolo Abeni wrote:
> 
> > If the mptcp socket creation fails due to a CGROUP_INET_SOCK_CREATE
> > eBPF program, the MPTCP protocol ends-up leaking all the subflows:
> > the related cleanup happens in __mptcp_destroy_sock() that is not
> > invoked in such code path.
> > 
> > Address the issue moving the subflow sockets cleanup in the
> > mptcp_destroy_common() helper, which is invoked in every msk cleanup
> > path.
> > 
> > Additionally get rid of the intermediate list_splice_init step, which
> > is an unneeded relic from the past.
> > 
> > The issue is present since before the reported root cause commit, but
> > any attempt to backport the fix before that hash will require a complete
> > rewrite.
> > 
> > Fixes: e16163b6e2 ("mptcp: refactor shutdown and close")
> > Reported-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> > Co-developed-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> > Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > The tags are provisional, waiting for Nguyen feedback/preferences.
> > 
> > Sending out early to trigger the CI.
> 
> For some reason patchew didn't tag this commit, so the CI didn't trigger. 
> Patchew did tag my patch about a half hour ago, so the importer doesn't 
> seem to be completely offline.
> 
> I manually pushed a tag: patchew/20220715-pabeni-subflow-cleanup
> 
> That has started the github and cirrus-ci builds:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2678690859
> https://cirrus-ci.com/build/4905612499746816
> 
> 
> I also noticed that this patch conflicts with Matthieu's "mptcp: add 
> mptcp_for_each_subflow_safe helper" patch, but that's only in the export 
> branch currently so we can easily wait on that until your -net fix 
> propagates to net-next.
> 
> 
> One more question below (about mptcp_dispose_initial_subflow), but 
> assuming the CI results are ok I think this would be good to apply to 
> export-net and squash further fixes if needed:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> > 
> > This will need likely some staging period.
> > 
> > "mptcp: add mptcp_for_each_subflow_safe helper" needs to be rebased
> > on top of this (we can replace another list_for_each_safe instance)
> > ---
> > net/mptcp/protocol.c | 39 +++++++++++++++------------------------
> > net/mptcp/protocol.h |  2 +-
> > net/mptcp/subflow.c  |  3 ++-
> > 3 files changed, 18 insertions(+), 26 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 21a3ed64226e..6f3324955355 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2804,30 +2804,16 @@ static void __mptcp_wr_shutdown(struct sock *sk)
> > 
> > static void __mptcp_destroy_sock(struct sock *sk)
> > {
> > -	struct mptcp_subflow_context *subflow, *tmp;
> > 	struct mptcp_sock *msk = mptcp_sk(sk);
> > -	LIST_HEAD(conn_list);
> > 
> > 	pr_debug("msk=%p", msk);
> > 
> > 	might_sleep();
> > 
> > -	/* join list will be eventually flushed (with rst) at sock lock release time*/
> > -	list_splice_init(&msk->conn_list, &conn_list);
> > -
> > 	mptcp_stop_timer(sk);
> > 	sk_stop_timer(sk, &sk->sk_timer);
> > 	msk->pm.status = 0;
> > 
> > -	/* clears msk->subflow, allowing the following loop to close
> > -	 * even the initial subflow
> > -	 */
> > -	mptcp_dispose_initial_subflow(msk);
> > -	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
> > -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > -		__mptcp_close_ssk(sk, ssk, subflow, 0);
> > -	}
> > -
> > 	sk->sk_prot->destroy(sk);
> > 
> > 	WARN_ON_ONCE(msk->rmem_fwd_alloc);
> > @@ -2919,24 +2905,20 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> > 
> > static int mptcp_disconnect(struct sock *sk, int flags)
> > {
> > -	struct mptcp_subflow_context *subflow, *tmp;
> > 	struct mptcp_sock *msk = mptcp_sk(sk);
> > 
> > 	inet_sk_state_store(sk, TCP_CLOSE);
> > 
> > -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> > -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > -
> > -		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
> > -	}
> > -
> > 	mptcp_stop_timer(sk);
> > 	sk_stop_timer(sk, &sk->sk_timer);
> > 
> > 	if (mptcp_sk(sk)->token)
> > 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
> > 
> > -	mptcp_destroy_common(msk);
> > +	/* msk->subflow is still intact, the following will not free the first
> > +	 * subflow
> > +	 */
> > +	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
> > 	msk->last_snd = NULL;
> > 	WRITE_ONCE(msk->flags, 0);
> > 	msk->cb_flags = 0;
> > @@ -3086,12 +3068,17 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> > 	return newsk;
> > }
> > 
> > -void mptcp_destroy_common(struct mptcp_sock *msk)
> > +void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> > {
> > +	struct mptcp_subflow_context *subflow, *tmp;
> > 	struct sock *sk = (struct sock *)msk;
> > 
> > 	__mptcp_clear_xmit(sk);
> > 
> > +	/* join list will be eventually flushed (with rst) at sock lock release time */
> > +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node)
> > +		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
> > +
> > 	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
> > 	mptcp_data_lock(sk);
> > 	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
> > @@ -3113,7 +3100,11 @@ static void mptcp_destroy(struct sock *sk)
> > {
> > 	struct mptcp_sock *msk = mptcp_sk(sk);
> > 
> > -	mptcp_destroy_common(msk);
> > +	/* clears msk->subflow, allowing the following to close
> > +	 * even the initial subflow
> > +	 */
> > +	mptcp_dispose_initial_subflow(msk);
> 
> Was the missing call to mptcp_displose_initial_subflow() also causing a 
> problem? Or did this cleanup end up happening through a different path?
> 
> This seems different from the "leaking all subflows" case mentioned in the 
> commit message.

I'm unsure I read the question correctly.

This patch does not add a new mptcp_dispose_initial_subflow() call in
the cleanup/free code path. Such call was already there in
__mptcp_destroy_sock(), and is needed to ensure even the initial
subflow is deleted.

mptcp_dispose_initial_subflow() is placed outside
mptcp_destroy_common() to allow mptcp_disconnect() to re-use the latter
helper while preserving the initial subflow 

Please let me know if the above solves your doubts.

Paolo


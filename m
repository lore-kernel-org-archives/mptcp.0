Received: from ma1-aaemail-dr-lapp01.apple.com (ma1-aaemail-dr-lapp01.apple.com [17.171.2.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443729CA
	for <mptcp@lists.linux.dev>; Tue, 28 Sep 2021 17:46:08 +0000 (UTC)
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
	by ma1-aaemail-dr-lapp01.apple.com (8.16.0.42/8.16.0.42) with SMTP id 18SH3R5I035728;
	Tue, 28 Sep 2021 10:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180706; bh=5dQGFRk1pqEWOo98VU/vJopbkf3O4vGjuSQUpdY9rEI=;
 b=ep9OdSIpT3+Ag843FLA6XcyxDkYLVb/3NCGgVPziwNMOyj7gYdh4LmLy/pwAK/RNTS89
 9pJb6TWbTRXlfhDE6wkB/AAlEjZke6zsgh+F5E2+/wEFZJhCwGpfgYKQssVFRnbHkb1c
 dF2RZTq3XLZp8z7z4mh4YhjOsXkkzzvt3+q+ZII0oIDfeZ1qUdcvBVmu+PHVDv/XmsdW
 QjG+JRzeU7DfvX4wF+K97o+hhI7E0zG3YsmLV9ifiaN31ZHBPSIuuHazmjzgyCTJrSq2
 V7gHsjsl6BEfVGSzSLx6jOwp0h91dBXWpgT1yc3QqQNgAWUPUiCoo6BDtUyK36s34+Sb WQ== 
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
	by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 3ba2e37m6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 28 Sep 2021 10:08:57 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.9.20210415 64bit (built Apr 15
 2021)) with ESMTPS id <0R0500MG7MAUA4G0@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Tue, 28 Sep 2021 10:08:54 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.9.20210415 64bit (built Apr 15
 2021)) id <0R0500W00LUNLR00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Tue,
 28 Sep 2021 10:08:53 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: e93e8d760996af5a2afab1c31269e637
X-Va-E-CD: b1a78ba8522fcbdf7017ca33a1d96957
X-Va-R-CD: 27c045b82c0aeb7bb013f93560ad8588
X-Va-CD: 0
X-Va-ID: 0530ce8d-d0fb-470d-8160-5053f80246ca
X-V-A: 
X-V-T-CD: e93e8d760996af5a2afab1c31269e637
X-V-E-CD: b1a78ba8522fcbdf7017ca33a1d96957
X-V-R-CD: 27c045b82c0aeb7bb013f93560ad8588
X-V-CD: 0
X-V-ID: a7061e85-f14c-410b-963b-01ace99fa774
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-28_05:2021-09-28,2021-09-28 signatures=0
Received: from localhost ([17.192.155.152])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.9.20210415 64bit (built Apr 15
 2021))
 with ESMTPSA id <0R05006GSMATKB00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Tue,
 28 Sep 2021 10:08:53 -0700 (PDT)
Date: Tue, 28 Sep 2021 10:08:53 -0700
From: Christoph Paasch <cpaasch@apple.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 3/8] mptcp: infinite mapping sending
Message-id: <YVNMJdLvelCxFaew@MacBook-Pro-2.local>
References: <cover.1632666254.git.geliangtang@gmail.com>
 <ccd77c87a8a73c7ecac8be52e894568147deeeb3.1632666254.git.geliangtang@gmail.com>
 <ede202d-674e-7fa2-44bb-b637a12eda6e@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <ede202d-674e-7fa2-44bb-b637a12eda6e@linux.intel.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-28_05:2021-09-28,2021-09-28 signatures=0

Hello,

On 09/27/21 - 17:32, Mat Martineau wrote:
> On Sun, 26 Sep 2021, Geliang Tang wrote:
> 
> > This patch added the infinite mapping sending logic.
> > 
> > Added a new flag send_infinite_map in struct mptcp_subflow_context. Set
> > it true when a single contiguous subflow is in use in
> > mptcp_pm_mp_fail_received.
> > 
> > In mptcp_sendmsg_frag, if this flag is true, call the new function
> > mptcp_update_infinite_map to set the infinite mapping.
> > 
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > include/net/mptcp.h  |  3 ++-
> > net/mptcp/options.c  |  2 +-
> > net/mptcp/pm.c       |  5 +++++
> > net/mptcp/protocol.c | 19 +++++++++++++++++++
> > net/mptcp/protocol.h | 12 ++++++++++++
> > 5 files changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index f83fa48408b3..29e930540ea2 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -35,7 +35,8 @@ struct mptcp_ext {
> > 			frozen:1,
> > 			reset_transient:1;
> > 	u8		reset_reason:4,
> > -			csum_reqd:1;
> > +			csum_reqd:1,
> > +			infinite_map:1;
> > };
> > 
> > #define MPTCP_RM_IDS_MAX	8
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 422f4acfb3e6..f4591421ed22 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -816,7 +816,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> > 
> > 	opts->suboptions = 0;
> > 
> > -	if (unlikely(__mptcp_check_fallback(msk)))
> > +	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
> > 		return false;
> > 
> > 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 6ab386ff3294..27d43a613e9a 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -251,7 +251,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> > 
> > void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> > {
> > +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > +
> > 	pr_debug("fail_seq=%llu", fail_seq);
> > +
> > +	if (!mptcp_has_another_subflow(sk) && mptcp_is_data_contiguous(sk))
> > +		subflow->send_infinite_map = 1;
> > }
> > 
> > /* path manager helpers */
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1cf43073845a..60953b61b3c9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1277,6 +1277,23 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
> > 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
> > }
> > 
> > +static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
> > +				      struct mptcp_ext *mpext)
> > +{
> > +	if (!mpext)
> > +		return;
> > +
> > +	mpext->infinite_map = 1;
> > +	mpext->data_seq = READ_ONCE(msk->last_fully_acked_dss_start_seq);
> 
> I went back to double check what the RFC says about the contents of an
> infinite mapping DSS option, since I had asked for the data_seq to be
> assigned this way based on this text in section 3.7:
> 
> "This infinite mapping will be a DSS option (Section 3.3) on the first new
> packet, containing a Data Sequence Mapping that acts retroactively,
> referring to the start of the subflow sequence number of the most recent
> segment that was known to be delivered intact (i.e., was successfully
> DATA_ACKed)."
> 
> The meaning of the last half of that sentence is not 100% obvious. I
> initially thought it was trying to specify a sequence number to place in the
> DSS option, but maybe it's only defining what the "infinite mapping" means
> to the receiver. The very end of section 3.3.1 says:
> 
> "An infinite mapping can be used to fall back to regular TCP by mapping the
> subflow-level data to the connection-level data for the remainder of the
> connection (see Section 3.7).  This is achieved by setting the Data-Level
> Length field of the DSS option to the reserved value of 0. The checksum, in
> such a case, will also be set to 0."
> 
> Considering that, and the multipath-tcp.org code, the only required fields
> to set in an infinite mapping DSS would be the data_len (0), and the
> checksum if enabled.

I do believe that the relative subflow-sequence number is needed as well.
Otherwise the receiver may not be able to properly map the DSS to the actual
bytes in the payload.


Christoph

> 
> Christoph (or any other protocol gurus), can you confirm this
> interpretation? That would let us drop patch 2 in this series.
> 
> Thanks!
> 
> Mat
> 
> 
> > +	mpext->subflow_seq = 0;
> > +	mpext->data_len = 0;
> > +	mpext->csum = 0;
> > +
> > +	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
> > +	pr_fallback(msk);
> > +	__mptcp_do_fallback(msk);
> > +}
> > +
> > static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> > 			      struct mptcp_data_frag *dfrag,
> > 			      struct mptcp_sendmsg_info *info)
> > @@ -1409,6 +1426,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> > out:
> > 	if (READ_ONCE(msk->csum_enabled))
> > 		mptcp_update_data_checksum(skb, copy);
> > +	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
> > +		mptcp_update_infinite_map(msk, ssk, mpext);
> > 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
> > 	return copy;
> > }
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index e9064fec0ed2..005c18e81e18 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -433,6 +433,7 @@ struct mptcp_subflow_context {
> > 		backup : 1,
> > 		send_mp_prio : 1,
> > 		send_mp_fail : 1,
> > +		send_infinite_map : 1,
> > 		rx_eof : 1,
> > 		can_ack : 1,        /* only after processing the remote a key */
> > 		disposable : 1,	    /* ctx can be free at ulp release time */
> > @@ -876,6 +877,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
> > 
> > #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
> > 
> > +static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> > +{
> > +	struct mptcp_ext *mpext;
> > +
> > +	mpext = skb ? mptcp_get_ext(skb) : NULL;
> > +	if (mpext && mpext->infinite_map)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > static inline bool subflow_simultaneous_connect(struct sock *sk)
> > {
> > 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > -- 
> > 2.31.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel

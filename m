Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088D39901C
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502103; cv=none; b=DiKtn4TYLmLbXNKVPaxyglXjT8VFxRnFIOEKgkUFZYKBr0U6BOPvtjA3sV27M7/utrhhhLsyZpMhAfsSLm20x/C6a0ylQYAjgei+fvD279B9Kk9d5m2Wj6FMLtscozZnG9N0G2aTjzBHjTuRrW5zGJwoHqZyYAtSOxuNMWU0LeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502103; c=relaxed/simple;
	bh=VJw4btjxB4dW49NmFJCy3OtaRSe3bBO3cz3SJgipb9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3q4j46noqN4uYtUSi2VD2Am+JqTSKfzeLpF+ix6Bet7dm38u9uSns501cerj6H6lTXmqaCiacnCbtP0wG9SUo+OWetDlt3gUQEeRpkYa9qGGmNNIPLgsI1q535keyPdkixT3X0quRj3k4YjcJJHfd/Ww5XVdVTg7SuhuHoh6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dvfpy6WE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dvfpy6WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780502100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyBZhylIkFLeuFbWMLGs+imU49A1l4mO7xXJMgp2EOw=;
	b=Dvfpy6WEsR3j5ODUv0dDDm7q9udulkTUhV4BntXLY/LKDkN/V8lBmVmMRyoLQpKDOCKbVW
	PPkuBjhfMroseLyI7NIaNKSTDd1EWFMQTPJ0rmLRJ69m69B3sOy9/uMa4MyTRJdPuoj5hp
	9kQ6d+MdnENwYqi6oY+/PPh+iPUK874=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-ZWJPMz1vP2Sr7eIQWfTFCQ-1; Wed, 03 Jun 2026 11:54:59 -0400
X-MC-Unique: ZWJPMz1vP2Sr7eIQWfTFCQ-1
X-Mimecast-MFC-AGG-ID: ZWJPMz1vP2Sr7eIQWfTFCQ_1780502098
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6417092so3606668f8f.2
        for <mptcp@lists.linux.dev>; Wed, 03 Jun 2026 08:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502098; x=1781106898;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyBZhylIkFLeuFbWMLGs+imU49A1l4mO7xXJMgp2EOw=;
        b=lPeQc5Pu7Gtk/iRpEtczZa9N5eDvurd2VDssSJITLCePQPDgDoSU87ssn5uo/p0DYh
         r1oMvGXW2mCC++zfP3SBnxnlM6xrsVgZvdRRbcu25426nKhU+mMJIVvGOlM2kUfZnH25
         JriZvb525fQZPYD444R+ZcAldn2ksh1TCPFSsuYpWBbN2P3B/woNbNGYmqZFwyLPINtW
         5IIy6YzGjmFyXkaj0Qt+y2IDaPJ1mmmVtgvsqurYUJprvAxR3AcJ5VjKS9eZsZ40SB9H
         PQW2iFhfXzdNw4ofPyNiKOf8Z+MLsQNXBOotRT54XOdsVzYsrvWmPEJYrkEy/zPTxu7m
         +htg==
X-Gm-Message-State: AOJu0YzVNYAdbD5csmGH7A2YxLzzDr2k4MhmzDu0swwAHWQrQqmBgKB9
	KuR1jHBr1ipicZZa2MlS2foIeN3m5tW3vKKOEvc7krcPvhkJGbUmZJQ2tlgIGLy5po9mkCxxUfl
	csxo8w2o9PY/FAcMPPdlEjiMji6LULrc5CrNRevz+oT0ltiDA+sD8mK0t
X-Gm-Gg: Acq92OE5q0MnvDCaGZ1ZY0O1SHc9pf5U9RtXkhR9cm/t8sKlasuB8TZhPGWFAgqYZVF
	9t1Kh4rnyi4Z/ZYqIu0q685UIAU3A7W/FRfGi73wJgdiuMbMZ5cJ3WYRfQEiCwciATcGCMoVJBg
	DpyU1DMLfiaZ4xK7Vn6z0jYyF2IJTzqju9uvb7FmyqFzr2KYYnCm++gpp98p3gOQnT9Leq14No+
	6VyZ6kEuXkEs4oWIEKNWAeDBD3xhi0ckYkQncRPxFxgdUA68dBXJkmjMAyqLTFIH70R2S5TE/8J
	VutP7++xTXl+hnJ2T07ccP6FZs2r+1EoheQ1w0d6lDpL8usF42IVhIm/RKd4iMIfOxussN5voq4
	/tO51fKyWkyH5i99cQVXLyQlldrnSOYKAHDMsPBi3huoUQ8ILasfnMndw2MvHO6QOI68=
X-Received: by 2002:a5d:624a:0:b0:45e:e509:d2fa with SMTP id ffacd0b85a97d-460217815admr4539738f8f.3.1780502098381;
        Wed, 03 Jun 2026 08:54:58 -0700 (PDT)
X-Received: by 2002:a5d:624a:0:b0:45e:e509:d2fa with SMTP id ffacd0b85a97d-460217815admr4539703f8f.3.1780502097954;
        Wed, 03 Jun 2026 08:54:57 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm13863126f8f.29.2026.06.03.08.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:54:57 -0700 (PDT)
Message-ID: <39fb9049-4494-4478-aee4-b85cc335a8bd@redhat.com>
Date: Wed, 3 Jun 2026 17:54:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/10] mptcp: allow subflow rcv wnd to shrink
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
 <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-4-a5ae7791754b@kernel.org>
 <2caac8f2-f9b5-480b-9764-45ff9818be8c@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2caac8f2-f9b5-480b-9764-45ff9818be8c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2Ay4b-V5T4OoYqk-be4vgo54XylI54LJiMEvYYqqflo_1780502098
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 9:25 AM, Matthieu Baerts wrote:
> On 01/06/2026 13:10, Matthieu Baerts (NGI0) wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> In MPTCP connection, the `window` field in the TCP header refers to the
>> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
>> constraint is enforced at DSS option generation time.
>>
>> At the same time, the TCP stack ensures independently that the TCP-level
>> rcv wnd right's edge does not move backward. That in turn causes artificial
>> inflating of the MPTCP rcv window when the incoming data is acked at the
>> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
>>
>> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
>> even when the sender is not misbehaving.
>>
>> Prevent such scenario forcibly allowing the TCP subflow to shrink the
>> TCP-level rcv wnd regardless of the current netns setting.
> 
> (...)
> 
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 5c228344e83f..12cbd98c7111 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -566,6 +566,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>  {
>>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>> +	struct tcp_sock *tp = tcp_sk(sk);
>>  	unsigned int dss_size = 0;
>>  	struct mptcp_ext *mpext;
>>  	unsigned int ack_size;
>> @@ -614,6 +615,12 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>  	if (dss_size == 0)
>>  		ack_size += TCPOLEN_MPTCP_DSS_BASE;
>>  
>> +	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
>> +	 * wnd soon: ensure that the window can shrink.
>> +	 */
>> +	if (skb)
>> +		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;
> 
> Claude has a comment about this new block:
> 
> ---------------------------------- 8< ----------------------------------
> Could this assignment perturb the old_win snapshot taken shortly after by tcp_select_window()?
> I
> n net/ipv4/tcp_output.c, tcp_select_window() begins with:
> 
>     static u16 tcp_select_window(struct sock *sk)
>     {
>             struct tcp_sock *tp = tcp_sk(sk);
>             struct net *net = sock_net(sk);
>             u32 old_win = tp->rcv_wnd;
>             ...
> 
> and later uses old_win to drive the zero-window transition counters:
> 
>             if (new_win == 0) {
>                     tp->pred_flags = 0;
>                     if (old_win)
>                             NET_INC_STATS(net, LINUX_MIB_TCPTOZEROWINDOWADV);
>             } else if (old_win == 0) {
>                     NET_INC_STATS(net, LINUX_MIB_TCPFROMZEROWINDOWADV);
>             }
> 
> After the new write in mptcp_established_options_dss(), tp->rcv_wnd no
> longer reflects the previously advertised window but the amount of data
> received since the last window update.
> 
> Can this cause LINUX_MIB_TCPTOZEROWINDOWADV to be missed when rcv_nxt
> equals rcv_wup (old_win observed as 0 even though the previously
> advertised window was non-zero), and conversely cause a spurious
> LINUX_MIB_TCPFROMZEROWINDOWADV when the assignment yields a non-zero
> old_win on a subflow that had actually advertised a zero window?
> 
> Would snapshotting tp->rcv_wnd before the assignment and restoring it,
> or moving the shrink into tcp_select_window() after old_win is captured,
> keep these counters accurate for MPTCP subflows?
> ---------------------------------- 8< ----------------------------------
> 
> I don't think that's a blocking comment, but I prefer to have your point
> of view if that's OK.

reporting here for future memory, too. subflow-level window related TCP
MIBs are already biases, as i.e. TCP sets TOZEROWINDOWADS before MPTCP
eventually growing the announced window, and even the receive path is
needs to change the subflow rcv_wnd, syncing it with the MPTCP one.

To really deal with the above it should probably better to add
MPTCP-level window-related MIBs.

/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C008392C57
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501867; cv=none; b=rN/qeWONNj+BVKxik7mVX8lDImgB3e2XzW+6yYQFGmhVsIZgqUshuPpHTBxB/BjorCgEx+NXOC8JN5FMScdey7ScdkhSL9MH5LFC9n15tDre/mbVPBhWwGPZKdgqzrHgHNORWDSjmrfSLaksC3bMbGbthCyRUG2fBEnngF1NZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501867; c=relaxed/simple;
	bh=OnXOW/pZpYfOoFMFdEoQDT8+Uxsoi2kUHoqT4bKwFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpE38QqZp8htoTUFGLPHsbg7YI3xmmn6AJS64Fr6y1AC1/8u6juCx8eEgaKAuZjkjXPzC3tZTkXRPZC/FWpUTIQMTC1kFsp4FZCoVK6J8xdnA1+8pMYZi+W6bRsF6err+85w84Usy4L4rDOvi2NvE4qEeZ7oDwQ0drWra/DpuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDIjAmo9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDIjAmo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780501865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz99w9geFvWSJl3cRpSO29drJppHwfs9QvZW1l/ahVs=;
	b=aDIjAmo9wV5jgXxL6pXth/LFzapR1Myk+Nyigg0NKcMkRzNv11L+qFVO6ISv07CBJEMSmB
	jVKsp4QXsEBSX1YNo7cbThY3xdqR+0y74Slsb0WZkRs/EnBybGWjE8herPjq81FdkgexZ+
	9vmIxtPxQwYiJ7dP3yZYgZnRqSGY2LI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-RFJ2QKa1MmaaaLb-IEujLw-1; Wed, 03 Jun 2026 11:51:04 -0400
X-MC-Unique: RFJ2QKa1MmaaaLb-IEujLw-1
X-Mimecast-MFC-AGG-ID: RFJ2QKa1MmaaaLb-IEujLw_1780501863
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a7aeaddbso8233615e9.1
        for <mptcp@lists.linux.dev>; Wed, 03 Jun 2026 08:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501863; x=1781106663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz99w9geFvWSJl3cRpSO29drJppHwfs9QvZW1l/ahVs=;
        b=mH7jyLMLFbfzyZAsCWnMAtROueAcowtGO6nvDTs0jT4J8rN+DQhPhTKkmKlUJUsqWX
         grGkp+WiSVGjVUqqZml+BJivZcTWWpDjWRKvPqh+L876vrRzc7awsjGja4c+IlInYYJ0
         /UgNobOqclCQyu5hEdC8T9mDxjpSYMStCn6NMvgubhcU3bAXxJCDKkITQLZMsauXmmMb
         qx1cIVOvN2ezB9qctnTusO3n+Xj3PGY3ajrHk6pYKrCHAbg2hnP4e1s06n1WkJ3o+9ll
         2mU93YfX05Q2pcqnnpn61Vx52TdlNwVgeYBldI36Aa6ayfCXRT1CKGsN1RHzPE2xIJ5V
         ghtg==
X-Gm-Message-State: AOJu0YzNp68iQVXAKueXCwlwDJTRhOouw3SQMacEvy7gdINk1WqV5J9e
	tHl76y38aWTQdklZw2m58czRK63IQMhlENKcHB0KamU9aItN6W3fVr9DItVFJy54VcjfqgYp5lf
	bkUR+kYYp8laWRlek5SPHdAn+erTzeEu5S1NgtBTSF5bjXNfIYo1rEN37ObNxvqFj
X-Gm-Gg: Acq92OGVoq1/puS0nUSh/RNFYiCtL8bcJIJ05ghKQ7acboAFq/KEgdZWDva4lS4uOF/
	BaRPA/bykuMVEGKCW0P79DbM2qvDMvkTGMWj6twxUf4VDKhyV9tA1OCa+yVjZXAjw9fIMdIBYpL
	ASQjAc7q+4UqdIbm6fIaS9gs1Ib3gACVdtKJhGMNRrJwqiBmVMVfLSmfXcrrAfFubpj+dnqK0CW
	9ufoWHMf+6vrWsVi9TMllbsqaoqI073uAINKrZZgo0PmWo9JZt+2GLqKrIZoz9Xj+egt5QSYMxu
	yc9TzL3Z9TzB0GI565Ayh414QMr224YnkKT0H1y6JBw9hoUxqU8w08EfTqS8r/rrQT38rPIlYjz
	WE4wxEy8UoYQDB/s2Vuy2CwZe0tXXvMBgh0+fjhEaVKb3+gKRT8VGGikSCOqdpbzQHGU=
X-Received: by 2002:a05:600c:3e87:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490b610e149mr55174415e9.1.1780501862829;
        Wed, 03 Jun 2026 08:51:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3e87:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490b610e149mr55173715e9.1.1780501862278;
        Wed, 03 Jun 2026 08:51:02 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39e024sm1792295e9.4.2026.06.03.08.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:51:01 -0700 (PDT)
Message-ID: <afd22185-3960-4761-97d2-c8987c088621@redhat.com>
Date: Wed, 3 Jun 2026 17:51:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/10] mptcp: close TOCTOU race while computing
 rcv_wnd
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
 <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-3-a5ae7791754b@kernel.org>
 <36a71a3f-9895-42e6-8dc6-02ce7b6cded2@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <36a71a3f-9895-42e6-8dc6-02ce7b6cded2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _c7CzDrlt6g_KlIVOe1iVPenm5V7erOSwdjGiu7Ncjg_1780501863
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 9:21 AM, Matthieu Baerts wrote:
> (-Cc Netdev)
> 
> On 01/06/2026 13:09, Matthieu Baerts (NGI0) wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> The MPTCP output path access locklessly the MPTCP-level ack_seq
>> in multiple times, using possibly different values for the data_ack
>> in the DSS option and to compute the announced rcv wnd for the same
>> packet.
>>
>> Refactor the cote to avoid inconsistencies which may confuse the
>> peer. Also ensure that the MPTCP level rcv wnd is updated only when
>> the egress packet actually contains a DSS ack.
>>
>> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/options.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 8a1c5698983c..5c228344e83f 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
> 
> (...)
> 
>> @@ -1708,9 +1711,6 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
>>  			i += 4;
>>  		}
>>  	}
>> -
>> -	if (tp)
>> -		mptcp_set_rwin(tp, th);
> 
> Claude has a comment about this line that is moved above:
> 
> ---------------------------------- 8< ----------------------------------
> With this hunk, the call to mptcp_set_rwin() is now reachable only from
> the mpext->use_ack branch above. mptcp_set_rwin() does more than just
> update msk->rcv_wnd_sent; the update_wspace label also runs:
> 
> 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
> 
> After this change, is old_wspace still refreshed for outgoing packets
> that carry MPTCP options without a DSS ack, for example MPC ACK without
> data, MPJ ACK, ADD_ADDR, RM_ADDR, or MP_PRIO?
> 
> The fallback-to-TCP path keeps the old_wspace update via
> mptcp_track_rwin(), but the MPTCP-options-without-DSS-ack paths reach
> neither mptcp_track_rwin() nor mptcp_set_rwin().
> 
> mptcp_cleanup_rbuf() consults old_wspace when deciding whether to send
> subflow-level window updates:
> 
> 	cleanup = space >= old_space << 1
> 
> so a stale old_wspace can lead to delayed or spurious window-update
> ACKs. Is this intentional, and if so, should the commit message mention
> that the change also restricts old_wspace updates to DSS-ack-bearing
> packets?
> ---------------------------------- 8< ----------------------------------
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b%40kernel.org?part=3
> 
> 
> I think that's fine not to have window updates when sending MPTCP
> options without DSS ACK, but I wanted to have a confirmation from you,
> just in case.

Yes, AFAIK is more than fine, it was buggy before: MPTCP-level rcvwnd
(and thus the announced space) should be updated only on packets
carrying MPTCP-level ack.

/P


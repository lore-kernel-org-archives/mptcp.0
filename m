Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6F4E0206
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006111; cv=none; b=lOPwlkrIlX3cI1wHGdxbMzJXPIvQvf2b89q44rusKIFptY+4K98aenWDLmC/7gOQXOMJaVE7ml99R1ZGqSXoTsOI7a9lRRfZmXsayzndjRtGErABgigvi3RvM0e4XKPN5X3um7G+JnjMpq6Vg0UmfzdNwY9iTm6ftvU4s1NJagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006111; c=relaxed/simple;
	bh=bDsUNSkjs/FlyzkubQ2+eUfYnX4CeTJ1aPsc/gNisz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH+gSNm7A1jhcHD6jixmf/vuPddyyXbpoi4cVW8WO8xKSoBlI2kIafDSok0UemeTN8f8csKrQXxbhslhihFDNDuv1i5pU4OXhnkTrcSoFPtDl4rfVcdduIRhsu3NcpiX98XC/NcoGbP3oG0Cb0O0GL0Pvg2SNQCdkzsQ4pSPYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTRIRdgj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTRIRdgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790006108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTP2SwRBukIzP2qE0+hVPmAsi+ftB+ZRXy8fpuSvdAc=;
	b=PTRIRdgjYyn/llk2pe460xdjZ/n89Yq4uJiJiRj5HlWLJ4ApDy532kUgtePjnQqW0LqSRl
	Q+JqHulr9bTCQKnYCNanuNxT5bXlCY62cJabXQV65zPZm/SBHE55CGfp4YvOCci/125wdu
	fM4vD4ukI7gpgM0vLEpra/Rzobdp88o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-dNXsc9I0MLKWwGdZnArFGw-1; Mon, 21 Sep 2026 11:55:07 -0400
X-MC-Unique: dNXsc9I0MLKWwGdZnArFGw-1
X-Mimecast-MFC-AGG-ID: dNXsc9I0MLKWwGdZnArFGw_1790006106
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e65bee41aso305275e9.0
        for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 08:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006106; x=1790610906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTP2SwRBukIzP2qE0+hVPmAsi+ftB+ZRXy8fpuSvdAc=;
        b=AAoInitG2Ajo61RNCPBz5E10coI+XFc0VgQ8I/5UGMWNw6rwp/gOMRwe5UUaNH19EH
         C8gSTVd7pOCBJ/makljSAoBcRtC9HxcmDCxF5PX/FvseFbJ7dD/g9FBSPo5PQGhI68ss
         AAJ879UqQkWGNqdIl64gd136/X3FGrDgKlQUYJjFNVBevclJL9Pr3kq7+xx2VKNCooRo
         G64wAVu+XgvYjBIEerZJ7JjN3TUxdNTJHp8p2vZK4Byeva/ESvbSVfN04jo1bV+Am+cd
         gtj0tEFvXm8zdmTUZHO81HNv0FOBmydIll77o3NIf0Slvyf/0hRbyk4GfBYNhlNv7vp8
         Ddog==
X-Forwarded-Encrypted: i=1; AKwUvBwxlut9YzcosJT4KXctz0RfDYBSth243ZNABM2M4TwuczqXRQqXCaZTzrByv0SrNkaobfiClQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kNPTbdJw71bE4GI8HHz4bumRwPG7yrR2O3Ejaf1ctuj3oKiSU+
	fNAgHDpI/6H0xPMD4mBNZbq1WwmmJEEXM3yhu13Q488ktw0By1WQwbAM91qjuS61fVOVj9CofAt
	/XoRqZKz7TEPo7FLLSWK2iBpUuuN1WLtOj9l+Wq8SWG1+7tTicYbNGep7
X-Gm-Gg: AYBFou2L/FSZ0xGEP+QuHwOTvVSHbLIVjS5rSaSfwg9HiZlSfsDX+aKYJg3G5e3nu+t
	EiWTzRhRH5+gQ4wGWteW+YxT2btRBD7rOt1+L0anDrqV0Se2V7X4a8qU4fwrC4GSFHQQuxKWxHv
	K5Ajz0etGT1z7Td2gBbh3JeuKy/kAVoJhsGZF5XmlZE4SKevlNaiBdprTD1YMME+AtNrzps06bz
	XwWevaiIeVncutqvGogE549vX9mR06qGO3SAptxKvWB781ypKuiwhYt2UeGF/7p5SfwGJmT2wyE
	CbMCRSV4iphDfXNcjgvb93QVg1BItMPv83i/W+MMsj3RFfMeMZdSj2GfX+1diA6lOD11YZPBch1
	tx1yWYziJC9YR7p4/mPVE+nbuzfyF0U+s5hs+rhpcqOAh74OJEfd1/SqZ0mPJJtcAE+ed+rcVnQ
	==
X-Received: by 2002:a05:600c:34c6:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fd88607e7mr1301845e9.5.1790006106222;
        Mon, 21 Sep 2026 08:55:06 -0700 (PDT)
X-Received: by 2002:a05:600c:34c6:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fd88607e7mr1301585e9.5.1790006105850;
        Mon, 21 Sep 2026 08:55:05 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc481c73bsm6271415e9.1.2026.09.21.08.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 08:55:05 -0700 (PDT)
Message-ID: <890795c7-f9f9-4725-9c2b-bb345f627fc5@redhat.com>
Date: Mon, 21 Sep 2026 17:55:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
To: Matthieu Baerts <matttbe@kernel.org>, Yilin Zhang <yilinzhang@moonshot.ai>
Cc: Mat Martineau <martineau@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Kimi Security Team <bug-report@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <20260920061904.3575780-1-yilinzhang@moonshot.ai>
 <aa299737-002e-43b4-ad1e-881720798470@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aa299737-002e-43b4-ad1e-881720798470@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FBU6g7PsSAkFVUN-r0TuF5hLVVZrMykG9OAv_p4p9fo_1790006106
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 11:43, Matthieu Baerts wrote:
> 20 Sept 2026 08:19:21 Yilin Zhang <yilinzhang@moonshot.ai>:
>> tcp_fastopen_create_child() hands the SYN packet itself to
>> subflow_syn_recv_sock(). For an MP_JOIN request this takes the
>> fatal fallback: the cloned child is destroyed and handed back with
>> drop_req flagged, but tcp_fastopen_create_child() does not check
>> the flag and queues it, so accept() can expose the freed child.
>>
>> MP_JOIN cannot use Fast Open: data on a subflow requires the
>> completed HMAC exchange (RFC 8684, sec. 3.2). Refuse it (only the
>> TFO path passes a SYN skb here) and let tcp_conn_request() fall
>> back to the regular MP_JOIN handshake; also strip the Fast Open
>> cookie from MP_JOIN SYN/ACKs.
>>
>> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
>> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
>> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
>> ---
>> v3:
>> - refuse TFO for MP_JOIN in subflow_syn_recv_sock() and fall back to
>>    the regular handshake; the TCP-side hunks from v2 are dropped
>> - strip the TFO cookie from MP_JOIN SYN/ACKs
> 
> Thank you for the V3.
> 
> Please start a new thread when sending a new version.
> 
>> v2:
>> - https://lore.kernel.org/netdev/20260903094010.4066892-1-yilinzhang@moonshot.ai/
>> v1:
>> - https://lore.kernel.org/netdev/20260902121247.3248539-1-yilinzhang@moonshot.ai/
>>
>> net/mptcp/subflow.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index af81ad5..2b454d4 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -348,6 +348,10 @@ static void subflow_prep_synack(const struct sock *sk, struct request_sock *req,
>>      if (foc && foc->len > -1)
>>          ireq->tstamp_ok = 0;
>>
>> +   /* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
>> +   if (foc && mptcp_subflow_rsk(req)->mp_join)
>> +       foc->len = -1;
> 
> This should go above the previous block, not to disable TCP timestamps
> in this case.
I'm sorry for lagging behind on this thread.

I think this is not the correct approach.

AFAICS only pktdrill or similar can send MPJ TFO; there is no gain in
keeping such subflows open, and some potential risks. IMHO this too
similar to the disconnect()/ADDR_FORM scenarios to embark into the 'keep
the feature alive' path.

I suggest just resetting the TFO MPJ subflow and avoid other possible
follow-ups.

@Yilin, please wait for agreement on this point before sending a new
revision.

Thanks,

Paolo


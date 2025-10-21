Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233BA355802
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067678; cv=none; b=YmjTug+r+Kpj6zuLgnfMVDfWUwMiWUjTcRASoHYGpOnSaaD5gxHwh2PSHDT4ara1fNl5SwJpNaE3J+PASxDNWU7EfnLoNNox57bVliQF8tUILsed30lKwnR/uObCuXdCKmEfnGg6Y0ZtAHY+8ECbCmB6yuMb4ofGm1A627oX+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067678; c=relaxed/simple;
	bh=7s+ZlTrFYa12IuhMJnSh5hm6Cj7aCov/KA4tP4V12d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8G9IY1Z4CkNFtF7AgqYu6fI7TAkJdX1NtF6meaI/gLjdQcMB56qqhfN6SsS2w5Nl4pn3rLoGYYHyy1ACdMS2RRVbDM3s2oM1r1CYXTkrCpFJmn/CoqtEoEB4Fh40yhg6Q0QQ25JKQxQhlZBItRAERIq+4ANQ7u7Mq+QWxUkvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8FjvKGg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8FjvKGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761067676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3afdReIUIX88NChE5m3leSUximBxxWRtiis58YBKrZw=;
	b=G8FjvKGg/4lfttRtB2weJyazlrZnknlw79VMl6o7oxLd2kIguvk2gEDdj2h+shc/u6KChk
	gf4sJblDCKX9bDCmUPaAMOaBlB2ywx7N7Xk4CdRjeDsHSYqVAHlBI/sqmGSLcM6swwdqNv
	ujmPlI5vfg9lxL2GWXDKO6pVX5mskIc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-lBknTr4GNDu2FDQ6TcSVPw-1; Tue, 21 Oct 2025 13:27:54 -0400
X-MC-Unique: lBknTr4GNDu2FDQ6TcSVPw-1
X-Mimecast-MFC-AGG-ID: lBknTr4GNDu2FDQ6TcSVPw_1761067674
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426ff59a320so7391511f8f.3
        for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 10:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067674; x=1761672474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3afdReIUIX88NChE5m3leSUximBxxWRtiis58YBKrZw=;
        b=QtXZO086bJ0D0yiFTyGDFRHn58TM3MmrnNbyEeZj/lbvVBSjKxXZgo8lPOZSqvzbLR
         FAULVYn1cQP/2LqyoHmL1DeYYSo7O/2cxovhwrxCqklJ/NWevhs+RIJeFWlOu4uZ+L4c
         8/VJ6OhSQ+zJeakH6JHzj39igItfYdGTBf5OWq4GPt3W5YLaSUJzIzH7XFrymFwPEaAn
         mAyNZzxhql0R2Yco4vskJhod0+T2JuUq9un/qx8ltj7ZbDwPmLVk1HOBZd0beknXSYRF
         z1aToesqdwldpY8AgI2X2Y0WY5oJsJGIHU7MSz8yuRtLOkEowKVQBXhuCBTULb2CueNj
         4y8A==
X-Gm-Message-State: AOJu0YyFQ9E3QpN9othkMFVSHjtbfTjcDFgyGP7Du2jn7/WWUp6HOR2h
	tCb1z5qKENT3xo8D4VOOMm6lsBhDQSdzUh+FdNzVY2S4FWzzmBYDRg/l2rnaDO7BDO1Vz39jgaG
	uRl31qPVuUxqo0UGA2VSLhNEgFFv9Oj/Shy+Ije+SoGfeVsnAqOaeScdu
X-Gm-Gg: ASbGncu5CVhrVkAyAgVHKFXqqZ1M/l3/hPzqJO7nhsTT4zwz7zbYd3ykzJbtdpw+ibz
	E6+z3pc9t7SvlQT+SWlzhX6IDK76yUQmypqWF92r4SEQspDZpJC911O9ojbldT/p/fUIJWlgBM7
	MaLqQJnNEEpBnJQR3MRXg2PCT85DzBuK1sx3Wlof8wdWJNxlbPkdYHOPzvMF+Ni1r1U4NwTJnDl
	fVg1b8Uos+4/hADS3MGxTQoa50CVAnn43glsqCumbmBTln9hz4S694X8vHKnyjWJ/gETIm9bwqz
	9OCltgThCIZNz1EXSt+3ahDhCk4q+4G9IRS+uSBDb9rVDm46bzC8xjaYnYZAT7AwvuX3TyUvRNL
	mZQzg9d2xQe67nLaH8K+Yt8yBAr/kj+oNTJhNRezO/tiXgfY=
X-Received: by 2002:a05:6000:40c7:b0:427:847:9d59 with SMTP id ffacd0b85a97d-42708479e00mr12236264f8f.45.1761067673666;
        Tue, 21 Oct 2025 10:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+2oVnzPmmhP9CieobwavfmggJ7kLebuUUv0W6GZY5SEsmWhGj6/OnDyE73cWuKQKtFz2KkQ==
X-Received: by 2002:a05:6000:40c7:b0:427:847:9d59 with SMTP id ffacd0b85a97d-42708479e00mr12236253f8f.45.1761067673282;
        Tue, 21 Oct 2025 10:27:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm20919445f8f.36.2025.10.21.10.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 10:27:52 -0700 (PDT)
Message-ID: <7d5a11f8-5ac0-49f6-8df9-cc8c43094845@redhat.com>
Date: Tue, 21 Oct 2025 19:27:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/2] mptcp: restore window probe
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, geliang@kernel.org
References: <cover.1760976334.git.pabeni@redhat.com>
 <59d900cbb2c2ff8e742d55a78e22727d1951bb51.1760976334.git.pabeni@redhat.com>
 <f473dab8-e461-3bdf-d118-2022aacb96bf@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f473dab8-e461-3bdf-d118-2022aacb96bf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: inSNBVVInbgcFtH9qth7r6AQEXqI6C6KbPb1wjoCJeE_1761067674
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 2:12 AM, Mat Martineau wrote:
> On Mon, 20 Oct 2025, Paolo Abeni wrote:
>> Since commit 72377ab2d671 ("mptcp: more conservative check for zero
>> probes") the MPTCP-level zero window probe check is always disabled, as
>> the TCP-level write queue always contains at least the newly allocated
>> skb.
>>
>> Refine the relevant check tacking in account that the above condition
>> and that such skb can have zero length.
>>
>> Fixes: 72377ab2d671 ("mptcp: more conservative check for zero probes")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> net/mptcp/protocol.c | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index bde76b7311f986..fe029359b7d7a2 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1276,6 +1276,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>> 	u64 data_seq = dfrag->data_seq + info->sent;
>> 	int offset = dfrag->offset + info->sent;
>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct tcp_sock *tp = tcp_sk(ssk);
> 
> Hi Paolo -
> 
> I appreciate the urge to tidy up the tcp_sk(ssk)s in this function, but it 
> does distract from the meaningful code change - and the updated zero probe 
> logic doesn't use the new tp variable...

Whoops, due to a bit of rush on my side after spending ~1w looping on
the splice selftests ;) A previous iteration of this patch introduced a
new tcp_sock() usage hence the larger diffstat.

I'll send a v2 with the minimal fix.

/P


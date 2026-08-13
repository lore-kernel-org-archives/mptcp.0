Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC037E5C0
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602889; cv=none; b=thRdr6TXCKj0+cgg++2sMcXKuKiivEC2TUuNgZhSX19umaWbQmCwcVQoSujhPk8GqJb3aI5IBNQaDlC8djyCX1ItXn0VHyzhzPqZJ8K1agvIhe3ROSgkDAy01udW7s1kjAsnOlph5is8zWPyER/lAh3kYvG9IiYxWKxGaEn3Xkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602889; c=relaxed/simple;
	bh=loFcgkWToyXwKy04k58v0ncEHhAAjmUVUIiINRU79Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUqPOhJe1h9qpt0y9kkc4GZ3vHPFeTeIazWEmLTGR8muzYN8NG32BMTTBf4SaOXEGJ/aa6sYZROPyiRoM3+N3Hrzv6QwY26/QmUqNuEHrftf60f8X+S0qJWiSD532hM75QBjn3EY/PHBInKOOTWyiHFrMLskAgB4nVKhpyizqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMftEyFf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMftEyFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786602886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0y0bv1ZKYWccbNlj+GApUAI+HjVyf+3rD/nzLYuawsM=;
	b=SMftEyFfymJYyZ/yKVZfElfBwHrMM5bn/fa07k8T994XcEnh0631m7OcXb8lnKeElLXvq4
	fmdNdP/4oOjHPzw7xFSKTCWP1CBqDO4kAJaqBwoX0w68iHZ/HhtNFgIgmyW/uI5KnGESE8
	3sax1K3VRnIwfGNRT8Fq9BYretDz6to=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-xVNvbqW6M_myAKVwzrbQLg-1; Thu, 13 Aug 2026 02:34:40 -0400
X-MC-Unique: xVNvbqW6M_myAKVwzrbQLg-1
X-Mimecast-MFC-AGG-ID: xVNvbqW6M_myAKVwzrbQLg_1786602879
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492488f8583so13831065e9.2
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 23:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786602879; x=1787207679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0y0bv1ZKYWccbNlj+GApUAI+HjVyf+3rD/nzLYuawsM=;
        b=tZbeWRnMT3PcRI+7ueJyIVVqI06fTVcrV3c+m+5hDsugvW5ib4NqX+nwzCD0CLqBhV
         4BdfAvZSBXGy6569S3tQC61Wz41egkQf+JEGNj9yYeKlkc5Uz4zdBlnU2nan2b2/n5WG
         PB3exvPtsuBy6HJZcJbS1Eo6shBLGok2uEXeyKUnfzoY9ElepYgxY/bZyrIr9BZJSNrV
         ksMQHARO6Is2GlV8br0fDi6wF8GWsfS9EgWoI5lJ6y2Qvrh9Psx1+DLjI3FKO5NhkNlH
         5pUOkKGu6rG2TyaZUyuhZjETd/3vN3wohrq7DqkTu52m97RfUyIoj+7R15VKjKkPH8pO
         oMaA==
X-Gm-Message-State: AOJu0Ywgs20g3eXSbawxSVk9GmlZnYWLB9trslIcKPfIcBxjnE+XMBcO
	aCsECAvYmwGvDthMUHqmxS7Qs+ztLzRUgZaOYjq/jilJ9iDojm09vSQbzC3ywNEDnWBDjKavIqv
	S2vnsxyq0FhkSegQe8qWUdkuNNpjn//1GeiCPectks6bp2I7JgH0fOeRfeWmv49SD
X-Gm-Gg: AR+sD11efUWrdifS1FUruuZY1rbJYq6fNPxtTQKj2Y1XrtAWACAHevjbPxyHDE6lC1U
	ce2AgP//mBXAw0cU22AnbswiMxOA5TjuD5IU6SaiFddLlWveC5WTwWkzZt51I5WoTl7Pi1mwA7D
	OnUhyBVI2cGVr3FwfX29yF9EQDyy6P8KxHbwu5L5WC2cK3jcn8knClQYMuAWiTTwam45N9lBAVD
	SRbZxzHDyUgPGVb18/CQ4aDatUY89CWucpp9EfFRmn1UiAqGrIGxrMSa2A0SApi8yMPYZ8x6wqn
	tPhoRELacW7cmIFf95KOCjz3VOIL/b1ZCKE+adoipfoueIF8aLj4RaC9/PNWZpg7BAKqTTAD2/F
	fwuPDAEjCJhgVFe/5CtOUXixp9ETvkQ+p0NMZCf8YHBrt/fGQk4d2kKo6ScvE1QTVmyWaaz+oD5
	g=
X-Received: by 2002:a05:600c:c054:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499821fa293mr23177665e9.15.1786602879281;
        Wed, 12 Aug 2026 23:34:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c054:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499821fa293mr23177175e9.15.1786602878819;
        Wed, 12 Aug 2026 23:34:38 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569c2bsm3877335f8f.12.2026.08.12.23.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 23:34:38 -0700 (PDT)
Message-ID: <0858d963-e20e-474a-9f03-ae5d323ff6d1@redhat.com>
Date: Thu, 13 Aug 2026 08:34:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/4] mptcp: a few fixes
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1786553006.git.pabeni@redhat.com>
 <cbdf8539-65c0-4bf2-ab43-bf3481b0971f@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cbdf8539-65c0-4bf2-ab43-bf3481b0971f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pZlXYA5ijO_E9jeeyc0gO0HAj930k9RBUiU6N3OoluM_1786602879
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 10:54 PM, Matthieu Baerts wrote:
> 12 Aug 2026 19:08:30 Paolo Abeni <pabeni@redhat.com>:
> 
>> This is mostly a follow-up to the recent OoO queue pruning series.
>> Explicitly targeting net as we have already a lot of patches pending for
>> net-next, and no need to rush IMHO.
> 
> (I hope it was OK for me to send a few small cleanup patches)

ATM I haven't checked yet if you already did... but pw says ~400 patches to
be processed before EoW, I would love if such count is not going to increase:)

>> First 2 patches addresses explicit comments from sashiko, 3rd one is a
>> somewhat unrelated cleanup I stumbled upon while implementing patch 4.
>>
>> The last patch fixes another thing implided by sashiko while reviewing
>> the mentioned series.
> 
> When reading this, it sounds like there should be 5 patches but only 4
> have been shared. Just to be sure: is everything there?
Yes, patch 4 == last patch.

Also patch 4 is the one I think opus 5 could raise some concern on. A safer 
alternative would be replacing it with the following, which is simpler, but I'm
not fancy of adding another conditional.

Staging the series a little bit in the export branch will give some time
to ponder about a better solution.

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..45d627981f15 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -995,13 +995,15 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
 
 static void mptcp_reset_rtx_timer(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	unsigned long tout;
 
 	/* prevent rescheduling on close */
-	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE) ||
+	    test_bit(MPTCP_FALLBACK_DONE, msk->flags))
 		return;
 
-	tout = mptcp_sk(sk)->timer_ival;
+	tout = msk->timer_ival;
 	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }


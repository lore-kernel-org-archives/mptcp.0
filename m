Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B730C166
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808241; cv=none; b=CPWqIrYTdY63844kAEsNrJLl99uqDzp4JmkXbJ+X6odFun5Vef2Yc7lQrZkeFBHeuiQMmzRZGLi0YaEMEgPzBDlj8FUIseeMu9k4bvht7YcCStduxB9GAq145P7RUqvNBpr5dYe+tKScfLS9bXgGTVxSGI5Pyw7UBMQtUwn+Reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808241; c=relaxed/simple;
	bh=x1tiN0Tdpc4srT9HgaOTI5FirtBd0ZFWZHSjBNjqy0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm4ekcA5AMoLnfBSPQpXeBOGCRJVapuCo+Dh9xbPpHwnVvhmz39lnTLyU3ZmOjAXax0WH6QFIpd6z218OV+MA/s07MijIryTuYpFoW4pV5uywsK7LKK1pZLKPY1asf3vS3Ni+hbwkGmlCCeX4Npc1ll0tnwtoUiipR37Wm47rzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViUC+GA6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViUC+GA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779808238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DbWCFpkMPAnNzqLd78c7dvT4Hch5JWOLrp40PcQv2Q=;
	b=ViUC+GA68PfUNNOBRyV/aUI7SoeuaAwfG63CuuixbDUnnWpbPg2lJsPBmpChAMBD793yZg
	KFgfIaoGO6C/hR77n/m8oAiX3GkNo11fP0gPv82Al9IjqWZ1OFRwiLjY1E0QsXvNG5fPLC
	8sEuMlVWawzb2TbyGA3X8sxDBY7Ljw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-I3j8tO7HOoet9chQUK0QNA-1; Tue, 26 May 2026 11:10:35 -0400
X-MC-Unique: I3j8tO7HOoet9chQUK0QNA-1
X-Mimecast-MFC-AGG-ID: I3j8tO7HOoet9chQUK0QNA_1779808234
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so26476265e9.3
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 08:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808234; x=1780413034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DbWCFpkMPAnNzqLd78c7dvT4Hch5JWOLrp40PcQv2Q=;
        b=lSe0bZZxewFYN+Kt+t8M2TOG6205c03wTxp+kv3XvAwwJrXVntuUSOEBVjxlskx8ze
         /UEpUTFsmxK/naT+x/sLNBODxk3xn4gW5/aheTTWQPYX6ixRKs3zqbRKERcS54oho9Ux
         5X8+/xbGbvaADXP1jc+bZn7leqjpwTcHZ2CwqcVa+WcgOMsyTZISNHE9MWsjPbf60C7i
         LnF8PDa9bVcoFbw91o8cAtaELam7NnF9D4ljGiZm5kFfxq+b9GSpPNZFjeZu07FpeGTZ
         eiyI1myuJf5lqkq0Cj0SubqByI0ZQAoXwmupYuztFJXic2wxXYMc3aneB+y5NShCPBT9
         Rkvw==
X-Forwarded-Encrypted: i=1; AFNElJ9svkTL5/2HvYfFh39LTKPsZGsvZv2QnL27BHO785icsOQsnRpPqV5E+TLOc79EsGWgEXBksw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1/xAupjkugao6wGHzbFdcngm8k9h7TKYFBKkKuEGT1OIeT/Rr
	ggY7XUtshBa0gI/xAkuqrIIeAK2PXRoHehPX3Xsf6iC1zTHs5Md7PfbkKvp4UZW1l8ioY7uiQPB
	u6L1aFBowSRWyE4e2SrEZyJXHBM7dqB9uwNuxPbcCE3U3DEBjpiKdShl0
X-Gm-Gg: Acq92OEv05T4ocScAQ+Q1zihflhvwrgSBAdqz6SHElOPXXMxA3okHnBXrH1CaU4jEmk
	9mX1p16ZR5XY/AGGF5wPrqCBiBsaDeI+63slkiB9vBTf0NNVuvBYdK2WPNndWW4pQjSqiQL49xi
	UXQfZ3BlECxmFxSx8PkopzLKhDNorkfhMFUWlWQ7ngZ7KL4+TrH+k7heGJe9wTXBiqEgr36KBO1
	TE4WFAu2L56uLuP0qn0JXXm+AkX6txf8+Foeeva67F3dbPpT+M+BDotU4jZyX8fxCF7UNc7FXdT
	TtX4SAeA1SUJbgi88lab/DcIKkKTGdd3GtngN8zyJDPOFGCEZnzs3Uz6nr+CzVvrSlf5Qi9msrE
	LW2F7SGeOrs3TkSEmVI6pQTerrv9Z33UVjiC1HYQusJZEWh55ynJzj0GYIw==
X-Received: by 2002:a05:600c:a46:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-49069da61a2mr131032855e9.14.1779808234194;
        Tue, 26 May 2026 08:10:34 -0700 (PDT)
X-Received: by 2002:a05:600c:a46:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-49069da61a2mr131032165e9.14.1779808233683;
        Tue, 26 May 2026 08:10:33 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ea134sm368943435e9.8.2026.05.26.08.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:10:33 -0700 (PDT)
Message-ID: <1488ea66-03e0-407e-a62d-222d9730ac7d@redhat.com>
Date: Tue, 26 May 2026 17:10:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 2/9] mptcp: fix retransmission loop when
 csum is enabled
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <eb3104033a7831b126ad918b7f6e5c06ac74c407.1779485511.git.pabeni@redhat.com>
 <c622e923-631b-4117-838c-25298aa7d120@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c622e923-631b-4117-838c-25298aa7d120@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5F1tJnQXaaE478J1_1jbcT68714kaWIacsNKEkD7TEs_1779808234
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 9:48 AM, Matthieu Baerts wrote:
> On 23/05/2026 07:43, Paolo Abeni wrote:
>> Sashiko noted that retransmission with csum enabled can actually
>> transmit new data, but currently the relevant code does not update
>> accordingly snd_nxt.
>>
>> The may cause incoming ack drop and an endless retransmission loop.
>>
>> Address the issue incrementing snd_nxt as needed.
>>
>> Fixes: 4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f14572fb1975..4f2b2868031a 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2867,6 +2867,10 @@ static void __mptcp_retrans(struct sock *sk)
>>  	msk->bytes_retrans += len;
>>  	dfrag->already_sent = max(dfrag->already_sent, len);
>>  
>> +	/* With csum enabled retransmission can send new data. */
>> +	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
>> +		msk->snd_nxt = dfrag->already_sent + dfrag->data_seq;
> 
> Should we use WRITE_ONCE() here, similar to other places where it is
> updated?

O wow, I (and sashiko too?!?) missed that. Yes, it's needed.

> If yes, I can do the modification when applying the patch.

Would be great, thanks

/P


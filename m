Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540765;
	b=cWi1HFEUGoiUKPNgaTG0Tm2ngbPmsBH8p+FVVnqX5X4otI2Ph+m9UWmaaGkuZG5QaLTr
	 2ul+jn+ThyFFUnzOwLXml2RAusrR5RtLrj9PjUHZcDTQHRB09USdR72RYySz1cCb4Av8S
	 UWT7O+lDcGFqGFHX8AWN+aKA2xL2uijALKnpkz42m+SIKX3QoI7VHqduDQhpsw/Tyk6KE
	 5wH99Njk7pWqWDY0lENVM8nL9w5fi/H0mIipK6qJM0c/LtNhGjtXGTChe30rO3uNJsVp4
	 xEyEBp2uSmcHIKsKuonhV0+Cz/YOM+MQOXhIweErf9cc8cxjCAQId3ifcHLimqefJ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540765;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2W18Sl1KVJQ4zdfQeYoRiZTmHNyLVcwiGsFXGI4ms/0=;
	b=xUStBnjd3Gl4s9WYXiihxVKq24E90AQOQSHrXsdKOemsgBovefFzCHg1cuk5L3vrtZoz
	 qM1rbIf7eGV0NXWMVZQ57KT+5uvrs1OyJZBQd9bvGOHsdw1A09cZpXHPSS40UUTIXXe+P
	 yRp3jQBQOgWNs0RFiH/yzHr8P3iww6hxoa/sEZLxqurHaDA7WOAwIhiTYc2mKxOTVqxyT
	 Kyez5xMSyB0HGeKkoGzTO+MxC4dJxe+oNIsaPJQMfyDujwaQvdluNptc7zp30F7W6L0+9
	 +FHxecBLFfp0xSGoRvBF8jw2+SDBYnDHj3C/Fz7McUdhPaP/h1G8sVg0EcSgRkIrmrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTNHWafD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A1606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTNHWafD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7A21F000ED;
	Tue, 24 Nov 2026 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540765;
	bh=2W18Sl1KVJQ4zdfQeYoRiZTmHNyLVcwiGsFXGI4ms/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kTNHWafDt8gj5FFNNJ2+k7WcsYD+iPd9y1sTGkCZ+8JwnMDm/jRpUXgc5QZxomXH5
	 ZSduWCxiMVsDSH9EGKhUOxJKavMt9vL2OTuJA1P171C3Vgz3huvUBbHFBpehAW3wch
	 UHLp3hNScVU0ObvqUCFseBR0/jz3ceBCyJ99Mv2pcp0sAU6t2YVJIcUrABhbJpd6Cg
	 flq7hTjEwDIbdnlQFfN392U3NFdFSD0VhOUQLiyyV1AidlZprfgKkxM6DB/4n2Aatm
	 kr7LAHDwhQf+H49hIS9BhdKQjgJVJyy5474StEeLk+FcoothyI/7nZSM+VB8Sxd48x
	 q2mHVdtabaNhw==
Message-ID: <43d2d331-920f-4835-9ab3-fa71b6022d8d@kernel.org>
Date: Tue, 24 Nov 2026 18:19:22 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 50/62] mptcp: continue the last mapping after
 a fallback
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
References: <20261121-mptcp-cmason-fixes-v2-50-00327fd1de1f@kernel.org>
 <179541555937.3133.8595018877227525015@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179541555937.3133.8595018877227525015@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 07:32, netdev-bot+sashiko@kernel.org wrote:
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 3590c1207e88b..f73e4b8deca42 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
> 
> [ ... ]
> 
>> @@ -1438,6 +1440,17 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
>>  	return true;
>>  }
>>  
>> +/* Fallback: dummy maps go on from the last valid one, unless it is old */
>> +static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
>> +{
>> +	u32 end = subflow->map_seq + subflow->map_data_len;
>> +
>> +	subflow->dsn_base = subflow->map_seq - subflow->map_subflow_seq + 1;
>> +	subflow->map_old = before(end, subflow->dsn_end);
>> +	if (!subflow->map_old)
>> +		subflow->dsn_end = end;
>> +}
> 
> [Severity: Medium]
> Can this deliver bytes twice to the application when only the receiver
> falls back, even if the sender runs a current kernel?
> 
> A probe or reinjection whose map ends exactly at dsn_end moves dsn_base
> but leaves map_old at 0, because before(end, dsn_end) is false.
> 
> Take two zero window probes. The receiver has DATA_ACKed up to DSN E,
> so dsn_end = E, and its MPTCP window is zero:
> 
>   probe 1  SSN P,   DSN E-1, 1 byte (content of byte E), with DSS
>            -> dsn_base = E - P, end = E, map_old = 0
>   receiver reads and sends a window update with DSS
>   probe 2  SSN P+1, DSN E-1, sent before the window update arrives,
>            DSS stripped by a middlebox

Mmh, it needs a middlebox dropping the DSS of one probe, but not of the
other one... I don't think we need to support that: if middlebox wants
to mess up with TCP packets, they can already do that from various ways.
Upper protocols will detect that.

(...)

>> @@ -1501,6 +1516,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>  				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
>>  				goto reset;
>>  			}
>> +			subflow_update_dsn_base(subflow);
>>  			WRITE_ONCE(subflow->data_avail, true);
>>  			return true;
>>  		}
> 
> [Severity: Low]
> Should map_old be checked here, before this branch commits to a graceful
> MP_FAIL?

No: it needs DSS checksums, a reinjection and a corruption...

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


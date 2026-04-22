Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17121CC58
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866029; cv=none; b=H9BqhlCh8kfRGf/dpo1YZHbs07zOM/xH6TUL+uZU/0jN3p9IBeBtca0qohRE+k5RT0nBa6vIXoxGcm8tH+QpP52DJDc5JPI5xmNXlnWwAUmAyhGY9LnEIa3qwVpSE+STZKReyWXVHXmstEi4smh3541Khw5k6NmIfnssbuKRWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866029; c=relaxed/simple;
	bh=C3+k2iC5ZiDDCaxwy8CZh/AMB6a/BERmIcpY9q9sn4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lApRGIT7pttxG4gpZDRoM9e6U/HIC4swPgTW4iT0YHgdXdjeSpHpIyk4aXUPiy1ZnroyxWBHCil059tbfM+UK4p5MoB0ij96JakqlieiFQgvAkGtUjyRNBbsN0t14pi51Kn/4n/W69eyZczfZAwE6AxfKh8W9U6YleCKGKH5WKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VetufQnQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VetufQnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776866027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bN/3fvyt9cfEOHTT3yzigoIAVa/6js7Hp+f8BGA7rTs=;
	b=VetufQnQmB42UNy0ACCzEsPaLdljhlxQNt3xhSJGqN+ShOgslJI7Tdt6KPF5DaklHQRDfG
	pHfZ8+h93DQtVSJQgZD+abb9mgnEnGYvxSjQbwUzRXN3k29zM0wIsAtlcXACQ3zJ0/dkvL
	5NhYt2TYDwKV7XJqLXrJxmmlHXWfu4k=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-FFecTk-zOpyA6s2n1m4AQw-1; Wed, 22 Apr 2026 09:53:46 -0400
X-MC-Unique: FFecTk-zOpyA6s2n1m4AQw-1
X-Mimecast-MFC-AGG-ID: FFecTk-zOpyA6s2n1m4AQw_1776866025
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dcc8f071b3so5829960a34.2
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 06:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776866025; x=1777470825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bN/3fvyt9cfEOHTT3yzigoIAVa/6js7Hp+f8BGA7rTs=;
        b=resfgCgkLORpTK4v45Ugx+2ETN/QBYvZYwW0egK3Bi3FiaKUB6yeD0IYlVLCEIi7Or
         PsG4t0n/8/iElgk+652mmlKUV0cngz4n2OitsbGNlWlnHxne8lI29iuM7N/XCMXK2Mbf
         3fYHAzOUkI0Ac0rNOPFCjo9+z4amcYE0ANASngPbuWt5XgjMTkTh9LhbY33ymxA7KLQq
         DyKtYbEOH0H9SOrGWC/7fXQjAEyS+Y/FzDKd2CZpem1P4TlTfoeOUYDz1R6RisEbzq6Z
         VDkzbpHJt9ani7tjTNKZ7HgVtfWcGaI/TRYO4WOPu5vR0hmL5Lp4ctffNn7U93hrN/2k
         qOjg==
X-Forwarded-Encrypted: i=1; AFNElJ9n+OGWHLVnL+EOiqBHLKEz/5++QMM52xHTV0DY0LJ8MKvh+G3qc7RuaeM7luoXclUn8LT7Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3ZVRCVsepBwh6mhp4S3Fn6yK2uLaLp0TJz2RT9Ra6Lsk7hERZ
	pM2s62caQOuMV50RQCZ4fZsd3aFPqvcLz5d9omW7F2V/NwS+3zYr86e+gllQ2x3mjQEMPssblgB
	BOKp6qOFEklOi4JJ+UGmoiKYD7AxeZrtZJEph6/LMrEA8CXkeeDqN0SlZ
X-Gm-Gg: AeBDieu13cmDJV2J1SR/TL4PLgi/Zk77GJY4nn7GeOII1cALgQVJrEw3pPY4Na3Gfwo
	+F6FN+LYhzX+TXJLbKqjfSMChxuO2Qx2BXBdh+8QrO1qPIE0vM3XuIC+x/LhdV7hc/SV2/pxgzr
	lHz+Ixb9NFLAJY44/gNlHouK9EH0lrdaqvTBkcUb9q74EttadB4nYMQNUMr8L68CqqySfzATvj5
	8Q3G6h0dOrIbLAd/RJ4ED3v/dWoK7H6Zd6UX5xwiRTOrBiZvFVvRQWXJN7tIQU6ZWHnJ6e+smy5
	Bvuxix8Q9SXjJAfdtmtU28D4BtJzsOQFSbCdKYMiFyHfG/QSCqvSXv7IZ+0qKBGISyb4E2aJdbQ
	fH8xt+GsYY5loPSZWUa8IHVWnWOhJZcNtdpSRv6uj9y1r64YiSYweaBX15MWQ6Uy7WzQ=
X-Received: by 2002:a05:6830:2781:b0:7d7:cb13:3fef with SMTP id 46e09a7af769-7dc951f32a5mr14343550a34.20.1776866025651;
        Wed, 22 Apr 2026 06:53:45 -0700 (PDT)
X-Received: by 2002:a05:6830:2781:b0:7d7:cb13:3fef with SMTP id 46e09a7af769-7dc951f32a5mr14343537a34.20.1776866025208;
        Wed, 22 Apr 2026 06:53:45 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm4923449a34.11.2026.04.22.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:53:44 -0700 (PDT)
Message-ID: <490cecd3-9488-40af-9963-0c138a9fd960@redhat.com>
Date: Wed, 22 Apr 2026 15:53:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to
 subflows
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
References: <20260421223338.52743-1-devnexen@gmail.com>
 <20260421223338.52743-2-devnexen@gmail.com>
 <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
 <88df3189-4aa0-41fa-9a58-0d17fb736c87@kernel.org>
 <a7234091-4141-46ee-8db6-cf01baa25800@kernel.org>
 <b0a882d8-3d33-47ae-9376-857f92bef86c@redhat.com>
 <0d414fe6-1775-4181-b6a7-9649c11c87ad@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0d414fe6-1775-4181-b6a7-9649c11c87ad@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p37hS0IjKQm3NCaaJUvFC2Vg1ep26L2L02XSFHbm9Po_1776866025
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 10:50 AM, Matthieu Baerts wrote:
> On 22/04/2026 10:48, Paolo Abeni wrote:
>> AFAICS for mptcp_setsockopt_all_sf() the msk lock is acquired by the
>> caller. Same for __mptcp_setsockopt_set_val().
>>
>> Side note; AFAICS a few other paths apparently lack the setsockopt_seq;
>> that is minor problem/not a real issue: worst case it will cause a
>> redundant mptcp_sockopt_sync_locked() call at finish_join time.
>>
>> The missing sockopt_seq_inc() instead looks really bogus, as it will
>> caused missing synchronization for later subflows.
> 
> Good point! Do you want me to send a patch, or do you already have one?
> (or do you plan to look at it)

Please go ahead, I'm lagging behind by far, sorry.

/P


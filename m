Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61C2FAE
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 10:57:59 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id i13so35642296edb.9
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nofk25BrgkgMTHSFLPzehGtUSAJtpxNLOkg0pfwXahg=;
        b=y0W1ZjQ/d0bNG2fETBm9rKg70M7pnfzypuORPRjW1A4a/ymDNIr30K+60keNNVR1Zw
         YLQPZJUrSjby3CpPwbIheIYzaacqRulhBX93q2uh+mPkgrB9hTD3Kn12WvnHh/o3K/d9
         yMmPYFYay+kzeTSx54wsMm2xFvpSmhB5s7QMC7H2sLa4X3KMHtHJQ8fFN1V/8rxTRV0G
         hoRdmf8JnbYCY0Ee/MusgftMr54Wu31ngqU4J1zWcbaoG4MuXm6hixHFCv2yMJ9EPOmX
         slxwMdt+SQsxMuJ/BqNG+JDAfukGkYMAie0YJ6tBLs9yhu/YgXX64wz5ohSQMULMxKDv
         XnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nofk25BrgkgMTHSFLPzehGtUSAJtpxNLOkg0pfwXahg=;
        b=B/upuK5uHo7Y2JouFtodPkc51P74gJzI0KxozvQ8VW2YPUIDDtRqDibsKxEzmm4kW4
         UjK2nDxE6WrNiR0jkMo9YIk/LTUCq0CRzD0rz+kK+CI60Fh4ue95UttthWsq/o3OiEIv
         wZbsls+Mrfsw47XQrUL+W+aZwBoHM3XVUvDfmtVDQSWhShrxgrpc8AuuOMiDnSmmqBbQ
         806/jv97uxr7ttR/Wm92JvpeQFl3jt8dfxJh956HN4qAe90JxtUXlGNb6C9IO8nKzXZ8
         L/H+2CITHe/G2jHqucwaAtOnaUgO1DJsprECdDTvfR7bb4Qc8E9P/txtHsTTS0MLpwAW
         cIpQ==
X-Gm-Message-State: AOAM530vyvb6wWhCMz3gOUE81OWmNVArKVp+6RD1+E1OCeUQ7Khd3ldA
	eHdt0JPjsV8O2i7qhcBH3Vqr6iQEHxRpHHF4
X-Google-Smtp-Source: ABdhPJxhd53UAPdidF6SdlNCaGvkSD0M9ZS3o0qC2A+JYRjWMHzZ/NwzmYIvMtvF7tGaZpD/Cf6ytg==
X-Received: by 2002:a05:6402:1544:: with SMTP id p4mr31199155edx.341.1621940277877;
        Tue, 25 May 2021 03:57:57 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8839:6e9:c432:46d9])
        by smtp.gmail.com with ESMTPSA id t19sm10955215eds.4.2021.05.25.03.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:57:57 -0700 (PDT)
Subject: Re: [PATCH v3 mptcp-net 1/3] mptcp: always parse mptcp options for
 MPC reqsk
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <7e97e8e3c7d9265dcbf098b57f12da11d0b383b1.1621521884.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <46d6ced3-5c45-e503-b799-368b97ab1571@tessares.net>
Date: Tue, 25 May 2021 12:57:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7e97e8e3c7d9265dcbf098b57f12da11d0b383b1.1621521884.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 20/05/2021 16:46, Paolo Abeni wrote:
> In subflow_syn_recv_sock() we currently skip options parsing
> for OoO packet, given that such packets may not carry the relevant
> MPC option.
> 
> If the peer generates an MPC+data TSO packet and some of the early
> segments are lost or get reorder, we server will ignore the peer key,
> causing transient, unexpected fallback to TCP.
> 
> The solution is always parsing the incoming MPTCP options, and
> do the fallback only for in-order packets. This actually cleans
> the existing code a bit.
> 
> Reported-by:  Matthieu Baerts <matthieu.baerts@tessares.net>
> Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patches and the reviews!

- f407a7aa834a: mptcp: always parse mptcp options for MPC reqsk

- 68379f4d6133: mptcp: do not reset MP_CAPABLE subflow on mapping errors
  - In this commit has been squashed "mptcp: cleanup error path in
subflow_check_data_avail()" commit

- cedf8c99c004: mptcp: update selftest for fallback due to OoO

- f76f266a991f: conflict in t/mptcp-add-sk-parameter-for-mptcp_parse_option

- b10d71891518: conflict in
t/mptcp-cleanup-error-path-in-subflow_check_data_avail

- Results: 9d8cf0870447..3ebd090a8fbc

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210525T105728
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210525T105728

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

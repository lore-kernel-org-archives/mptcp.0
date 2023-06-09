Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F561950E
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:31:56 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51640b9ed95so3255984a12.2
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686324714; x=1688916714;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLD3BMGdWifONDYQxraUv5AqcrzJ1E26WePQk03Algg=;
        b=l+Zlr+43PpsqCNgT4LkT2+H5H9gcB4h4WZCba5SFfFXYWp9bLCaqbuuNT5eknUe81V
         l5FD0yrfr/uvPGl9Vicuc8HHOdMGa6ghCCSwVRFQnd/iUNdbSuEVBSRcUt26QABlvq6v
         e16cJ8ia6ovJBowsDXI1Zc2+tUM53BHxZ4E+4EW0X5198AdgYH4/QBFkRxq7AzTQHTV4
         eMovPHo7gvbPvnAltJRK6K7DmNdPSVWPvnGRzST2/p9GKN0usUDFEetQCFAMpRKMQR+F
         e+DWYaOH5PjHx767zvOyX8XBaqUDKShNSOOeDDwYjhNtSxjCm4k52P1ugkvWgV8fK8kv
         OBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324714; x=1688916714;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLD3BMGdWifONDYQxraUv5AqcrzJ1E26WePQk03Algg=;
        b=AheNNritQQ/F/K52042nwcBxWBq5sdcqaFqlU+Q1U6enpmD1SbERAikChRXxKHnxaZ
         X2TZd6TymL1UNO89wYVXY14R/goqZ6n/hP/XGpsLyBdeUpFjjmv0WxJJ/VQqQCFKtEIg
         gS72gH2+20ryyPGvyFkKdYFp1iUtswzD31dSKEWmARgZBwOj5egWu7ej7huIQV8WhSgk
         C1b4YuE8FFhX7BSfKebeCWKMimgaAkmqYWJWr2oY8GzcTREpEfT52MEklbKoDM1yQwXd
         7hO9G6XjrzhZqpSLdRkkGCA1GNqXa2JkisIvhm4gm/hHyOpTxf7dRBkSr58LQTPxowJ/
         ywpg==
X-Gm-Message-State: AC+VfDz8dbB6Z7UQ4YOY+LEpUwfsWcIAvq4msVwpiFj9vFJC75sTUMAV
	duTFd6Lse5zocIamrn9zq1XgqA==
X-Google-Smtp-Source: ACHHUZ7OTHIPrWuuWuu31HAx9GDNmJsakzMPxhE/+Oww7alCibeCT2zC7gmxjvfURYuiLcV9FRNK5Q==
X-Received: by 2002:aa7:d29a:0:b0:514:8d9d:33a2 with SMTP id w26-20020aa7d29a000000b005148d9d33a2mr1623458edq.13.1686324714459;
        Fri, 09 Jun 2023 08:31:54 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7c38a000000b005027d31615dsm1873574edq.62.2023.06.09.08.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:31:54 -0700 (PDT)
Message-ID: <dae97413-d044-ff91-af94-441ff9d077e1@tessares.net>
Date: Fri, 9 Jun 2023 17:31:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v17 7/7] selftests: mptcp: set endpoint out of
 transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
 <2673d5e34566da219d6c5d31ac385ea778e32040.1686138130.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2673d5e34566da219d6c5d31ac385ea778e32040.1686138130.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 07/06/2023 13:44, Geliang Tang wrote:
> This patch moves endpoint settings out of do_transfer() into a new
> function pm_nl_set_endpoint(), then addr_nr_ns1 and addr_nr_ns2
> arguments can be removed for do_transfer() and run_tests().

I still have the same questions as on v15:

Why did you switch from slow to speed_10 here? (see below for more
questions)

Does it mean that this selftest will be even slower than before?

(Maybe it is a good opportunity to switch to key/value instead of
positional parameters? I know that Paolo was interested by that at some
points)

  speed=speed_10 sfflags=nobackup,nofullmesh wait_join=1 \
      run_tests_bg $ns1 $ns2 10.0.1.1

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

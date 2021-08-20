Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712E3FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 07:45:33 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id bo19so12657456edb.9
        for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/2kY3+AICjI4OWSIthnIjqfayHehCpajkPTp27l/Gs=;
        b=ie+9KKULo20Fdl8bOs6N2Fc7hGK4L0DrYhsiL9wgfWKwQiZaYpSpLx+ZKZexZMT2eF
         Vv6y3bGIei55M8Irpgpi87pPtm6wjTfkLs9tjprpE92Wpr3xJrCekOl7utb8n5mgygdP
         h0GyKVOdCkteWfFYBN5Ja0pDA60s31r+1EHsKowJm/yxYsjN9hmoM7Az1VSFJpcAV+bB
         dRVzIzpW64pq5W9HhOwaUgtC1tL6SxMGB1VAzDaKen55X4wf31wuhdJto15fbXFkZi3i
         5zlyKRM2CvbbVNsXD15OaCLIrnR8xX9czNLwRKm1ogrYeBDKIuOeUXu2g/5ITYlpCxeo
         biog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/2kY3+AICjI4OWSIthnIjqfayHehCpajkPTp27l/Gs=;
        b=itQEy0I4l9I6WlRMaf3RbqI6fZqZiMenkpk9lXFKvB9PdRUj5YwEi5sq03YLZChYfs
         DlZeA4sjiUdNhVqmGDLUCCSSqpmOwFfh0vP1/RzKC+l/VUQ1i+d/uI4sYHiLU7tvOlzu
         DoXwMPgJVOlx1FGBXuRogkSMOrb8ulE7iOCAMrHRSnCT+xOTFPQX+g5FwBphNDOyZlmz
         hNkILjFTB5k6aRnUvctgrOukeNgBecVVZAJtBqBQyUkL0BXAkA1aCm+cMRuHjmPhyEr5
         rkdvKbYq4QVfPLHbzN87SiJlv+3Vfddey8u3k1IaiQqbQ9Q7c9O+1worG83yzEeA44qv
         IUHA==
X-Gm-Message-State: AOAM532ES/v+K6/5Jm8fBef4ZqpCHTkRBWBjBPbiQqcB5l/otzFBv3z4
	+eYx+YeyIlP8IZS5npQCM+z9d+ybHZiVIA+E
X-Google-Smtp-Source: ABdhPJyHBXc9/PAtkvgVPVU35MrapkfJNwDVOjzaGF8mIOP6VfTEid0P4Kln9X3MoiVvA49zPFdqLA==
X-Received: by 2002:a05:6402:1c89:: with SMTP id cy9mr21365902edb.140.1629445532026;
        Fri, 20 Aug 2021 00:45:32 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.142.31])
        by smtp.gmail.com with ESMTPSA id k6sm3011724edv.77.2021.08.20.00.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 00:45:31 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp
 getsockopt test cases"
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20210819134026.1155338-1-matthieu.baerts@tessares.net>
 <bddda8b-1340-1554-c41e-236956bcac@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8e03b5e3-22d3-c80c-a08f-c43819f0a216@tessares.net>
Date: Fri, 20 Aug 2021 09:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bddda8b-1340-1554-c41e-236956bcac@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 20/08/2021 01:20, Mat Martineau wrote:
> On Thu, 19 Aug 2021, Matthieu Baerts wrote:
> 
>> selftests: mptcp: ignore mptcp_sockopt
>>
>> Similar to what was done for mptcp_connect and pm_nl_ctl.
>>
>> (No need to add "Co-Dev" tag of course)
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>    to be squashed in "selftests: mptcp: add mptcp getsockopt test cases"
> 
> Looks good, please squash!

Thank you for the review! (I wanted to apply it yesterday without a
review for such patch but I was delay with patchwork issues :) )

Now in our tree:

- 4ba70b420503: "squashed" in "selftests: mptcp: add mptcp getsockopt
test cases"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

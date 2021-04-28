Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3552F82
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 14:03:58 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id d14so10551134edc.12
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGOH6z5pfTtTaIcVTra2LqY5Ky7S+kXFI7KyNcyhsKY=;
        b=qyWhnC4D46YPyLt0v8WJIfMfUt3oVoF0swFuF2W0XpJiAMrvm70Fkf0MplYkaExnNV
         ZGJFUIDM2rkhj/sB5YqrjT7rtTSpgPsEVKFQ1WxxCLD5VEwC3dUL4DY5jQ+BzwYjq0GH
         bXSXfBnMINprQDQqgvP1mDuH1OXALbF3+vVLSuHhPqa100ImVFolTlxy3lgsLKZg5H21
         fVITOJcJ3XyYcApLOwR6xqFMA3vh2Qgx5IfiW6kxOPA1IQZqrok9wtiWFQQC2uFSdb49
         daM90b0zU6a0iETod8f0I1lFtdlITNvSPI9qC8zN1F3y7fTOTPRZbrbfBK71fk9C7IEu
         7dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGOH6z5pfTtTaIcVTra2LqY5Ky7S+kXFI7KyNcyhsKY=;
        b=PiFSzXcW9PncKUymLwVubqO0cTG25GtfAbu9VnvxuVpa94QYN1hJAalUWx53c9xQVG
         3vIPm62RGB/CQe1xrht+kbVmFtT9IeQHpTJ5O3mmfMNX2keo0QGpnjm7dux0yUjn/m0O
         BSec2PpCmw4tihfOwfDrASFNiiTMRRCMO+ha/YFBpVF2Xf3UKsxp3GcYyuQFieQn4fZp
         tlA31e4vpvZI85qsRhbJKrosLV90afPIMQ4ZkfO2lTksrQORsOJCyv2UhClwLeM4LmWv
         Vod+VVzKS1PDZcrgd+FpjPjN96o05cC51s+lPyFio5mMrzSBs69uvs0uxChIVZrVRAB4
         T8hA==
X-Gm-Message-State: AOAM530SNkKMYnDYS+3dORbMo6ZhS/tVtaFjlWwbbpr78VSif2wid4Ok
	sRejP7JwLjkcpbhcz6AlQOkumYL7dTl8YONVUIs=
X-Google-Smtp-Source: ABdhPJzTIqwY0qMcsKpr1x3xcH9lUgPWAkEhFtjdE2MFDKNxFyIHYJqY3U/TCaC96ADLVcdRiMVnXA==
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr11861933edc.210.1619618636931;
        Wed, 28 Apr 2021 07:03:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9a01:f17b:24ce:3558])
        by smtp.gmail.com with ESMTPSA id b8sm5084061edu.41.2021.04.28.07.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 07:03:56 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] mptcp: restrict values of 'enabled' sysctl
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
References: <20210428111737.3611480-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c366c6d9-248a-9a52-1fb5-ab57b6b783cc@tessares.net>
Date: Wed, 28 Apr 2021 16:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210428111737.3611480-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian,

On 28/04/2021 13:17, Matthieu Baerts wrote:
> To avoid confusions, it seems better to parse this sysctl parameter as a
> boolean. We use it as a boolean, no need to parse an integer and bring
> confusions if we see a value different from 0 and 1, especially with
> this parameter name: enabled.
> 
> It seems fine to do this modification because the default value is 1
> (enabled). Then the only other interesting value to set is 0 (disabled).
> All other values would not have changed the default behaviour.
> 
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thank you for your review (on IRC).

Just applied with your ACK:

- e96c1cbd9dfa: mptcp: restrict values of 'enabled' sysctl
- Results: be556cd0eaa6..837feee36a25

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210428T140248
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210428T140248

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

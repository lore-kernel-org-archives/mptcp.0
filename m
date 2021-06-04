Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62670
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 20:07:21 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id s6so12471309edu.10
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/41+cYSJzu5W9/iuzcKnNKh4Lz2f3PcTNxDrtOWLvg=;
        b=V9ai2AfFDfQVoUEl2Oe8nsJY676yLQE236J3+x/IdvcgUm6DFYA4GpQJGOFrjNRT5p
         dU7z1L34sPrsd7DraRXw1bB2uhs4DNt8mjR1aU0WhVaxOyEE1zC16BdvPzTlnG7mXBN5
         0cKVMyzCoVNvOi+K8bZM7FjuiWX3IaU27toIVhX4VRNDAjjXE0w3QNLshEUvtj5wmp/c
         dt+ljpNmUWUu978A5vsyor8H4U3KOigVrmn2jIU0JS8XDemcXMnuYPjtB5a/LJ4hkC0G
         D+g0IkyUHVxr4OgCXYJOTRfW1gQdDs2XjNmAbw89d+K81QnudfhnXE++CiPp9u8KUzeP
         zXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/41+cYSJzu5W9/iuzcKnNKh4Lz2f3PcTNxDrtOWLvg=;
        b=F3VuPUUhhPSo97FZ1XHlYx8RWRhhBmadP47l39r0OLN4kRL+kPJ8/Fa7lm1gdJepE1
         1KybcBDdU5mfa3S43rotO+2WB8vZ+UONS41x3QQ72TMp26WUvx3YYCGlmLCW5+JymQQa
         pr/HAENOY5cMdS3RIbgb51jZBnqOPZadaMFtJA9pqP0YCRgCu6fWBtEmaSWjbOy0syFF
         QqH2UG6JklHyFDGRc2dzx2DbvbPdi9k7NV6xxAXUrYUu3A/e4ZsGV2DTYFVSInRP/27G
         xCxvObwVm7ugJ5svRcOjed/9ETiRn62qqwnJtOifGg3+2DlsZRtsqAS1/zKXhl1P/aV0
         QTFQ==
X-Gm-Message-State: AOAM532fvu1Ev78sgDnIz7nClYgAqrMBCiEatFpmBkXH3Q/wajA7y+G4
	L38FbAbTpqOPO6PHZqlOodHdMbazL9mVhxyU
X-Google-Smtp-Source: ABdhPJzhG7+NvR7YJ5HMYMjgGRvWUTJUOpATr49zyvD3LNwrBhlQzSyMbuh3KcNHXY9PBhNsEzf+9w==
X-Received: by 2002:a05:6402:3101:: with SMTP id dc1mr6477717edb.324.1622837239952;
        Fri, 04 Jun 2021 13:07:19 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id n2sm3737603edi.32.2021.06.04.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:07:19 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>
References: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 mptcp-net] mptcp: do not warn on bad input from the
 network
Message-ID: <2f350f42-4bb1-5092-120a-b9f58d7a21e3@tessares.net>
Date: Fri, 4 Jun 2021 22:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 03/06/2021 13:31, Paolo Abeni wrote:
> warn_bad_map() produces a kernel WARN on bad input coming
> from the network. Use pr_debug() to avoid spamming the system
> log.
> 
> Additionally, when the right bound check fails, warn_bad_map() reports
> the wrong ssn value, let's fix it.
> 
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/107
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

- a88964048fec: mptcp: do not warn on bad input from the network
- Results: 02c88cfc4215..102ad1154235

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T200651
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T200651

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

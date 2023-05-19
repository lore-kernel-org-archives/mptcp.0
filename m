Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9F6108
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 09:38:16 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-966287b0f72so561494166b.0
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684489094; x=1687081094;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fviwLPr0+Y0kg9uVxNEvpXACGmBUOlBjh8QX5Gd/sQk=;
        b=H2Q/XgjFCCZ9fBO/srekCvRYQtUfI9VqMX/G37qOKtVw6NZ+qWk1cBNwWjnkJxkYR7
         RibYglmgH9b0ydlX5JVDqJJE0MkeUExZ1NNzGuc58rzuVMIavGnvyieo3CCSG16ULM76
         jZJswFNP5mM1dVZa7Klt6fX18nfH/X6t3DkBPQ2S82W9YLgbfUJjGqIabl8FY7wBMz9v
         M6fm48FD52DE5IMCQH52jJFIhQTQaJ1nNIIu05vka8mqzn8lLbERTni306BiPNwpkHzQ
         e9q0oD3RmVpNg5JodqBlkV48eeqM5pW/f0FHNZmEL+bjEU6MdPxj5IOI63Ifo2dz1hZL
         kqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489094; x=1687081094;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fviwLPr0+Y0kg9uVxNEvpXACGmBUOlBjh8QX5Gd/sQk=;
        b=h59Z/RA6brIDTEJa+3Ve6fyZdFYDx8Wck5BLsCRtuvCHqtRND/jhghetg5H7K8mQ6e
         c+pe2I1YHN8oIeKRRXD/Eo+lAJpxSuTBcnr8NPTFcTJjSjERPTbn4Pks/SBqvQVuGI45
         bJY2Vg9u+xJR8eYhqikqBlhITxiRdw/2AxPwQlJguktNN6GEfJpU1bw8I9tkrf1nNsb0
         zLdaFvWpW8vrJD3MugKiMn50mfDXROoBCcrLrpMGnubcF3dr/j2/CZxw7aQGhsIDsIID
         mtQJTfdmUM4S2nEHuzP9AmvO8vwThX/5iHSCPp3iiuNPFxPrq4NbCVMhYL38KC6zrEVa
         oMNg==
X-Gm-Message-State: AC+VfDzxCh4do2WdGN9z9hfdK3+dE3BlviLZycneDOeqC/zTOJvTfyhl
	3m3V4RLUWkHUy6KDuQfq9zd/jkkPyHqEst25HA4=
X-Google-Smtp-Source: ACHHUZ5/zF0O6yzoIF2XYLOjmNL70q6XqxXXAHTlCFjafsWEMRtm59n8vM8fzLsHyWkV5w3iPdQg2Q==
X-Received: by 2002:a17:907:2d94:b0:96f:3894:161 with SMTP id gt20-20020a1709072d9400b0096f38940161mr1298290ejc.28.1684489094336;
        Fri, 19 May 2023 02:38:14 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906841800b00965be665811sm2078313ejx.2.2023.05.19.02.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 02:38:14 -0700 (PDT)
Message-ID: <6980ca9d-5fdd-ad78-932d-a9a9cc08b033@tessares.net>
Date: Fri, 19 May 2023 11:38:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v4 1/6] selftests/bpf: use random netns name
 for mptcp
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684362296.git.geliang.tang@suse.com>
 <ca8f8f11a0437a4d0cc43582342f8780f262f888.1684362296.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ca8f8f11a0437a4d0cc43582342f8780f262f888.1684362296.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/05/2023 00:29, Geliang Tang wrote:
> Use rand() to generate a random netns name instead of using the fixed
> name "mptcp_ns" for every test.
> 
> Fixes: 02d6a057c7be ("selftests/bpf: run mptcp in a dedicated netns")

If we add the "Fixes" tag, it somehow means the previous behaviour was
buggy. I agree that it is better to do what you did here just in case
the previous netns has not been removed when re-launching the same test
multiple time (what a CI would not do I guess) but I also see that most
(all?) other BPF tests creating netns' use a fixed name.

I hope you don't mind if I then remove this Fixes tag when applying the
patch.

While at it, I will also explain the reason why this patch is needed,
something like:

  By doing that, we can re-launch the test even if there was an issue
  removing the previous netns or if by accident, a netns with this
  generic name already existed on the system. Note that using a
  different name each will also help adding more subtests in future
  commits.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEE23A2
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 10:17:05 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id b2so26544237eja.7
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eM3fCazB9KskjM6+OzMJXaVY7brCWojqdA1mHI3DzEM=;
        b=KoqxYhHXBCQ3PcXd9xk2ovv3lBjods3b4n7Hj7eQqFg9IuK3LJNjV6VyAXj0H05xTt
         1+SJsaRX8Pv7K69Am78tlb8GicMEn3m/JqnIxGaFsuTrPWjqVtOAcU+DFNf4GZeGx6uI
         +u7SoaYNMtaTDxkN48KQIrIsulNyxEuhJ0B1Q2RGbe3ukSrh/9hYHQ/LVPZPS/j8Ez8U
         K/RlWuHc9Qxv4Iutd5xXtSaP9I566T65lBMCh//cp37Xj08iDaUQe0gOacAtEoBZQ+wA
         LhY9IbAR+wjqU41eBEx9EpLQOBSuVMs9CauSF9fVJgCIwszuvvDRWPjb+6PGgdDv97lO
         RGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM3fCazB9KskjM6+OzMJXaVY7brCWojqdA1mHI3DzEM=;
        b=pVYK9FcD2zz8lQSf+0LzrVrV1Exnln06hbhILeBvp6bR2YaKoRHgerik+tSXLfDLMP
         LtMSZ4FMwSPMIWp9910fSLjfiT/bv3nCU7dK5qo46+0kQjua7qIReSFr84WuIAyVrbnF
         bco1F+DVSSdUDwnKnWSzqUQ//2aZ9yF+v1Gxr2ezEsJhlzly+t3fPgmMYFNgZwgzy9OI
         YYRYQ3dHpG52+ow3s+JHQJMjDaJTq1N86yCURAowvxDslszoTBsP91EgCAM3Dg1sh7bL
         wC/xTSgmktZLeanZXnThtyHyrEFYP+ltSWKtxUQruK3sp097Ei1eA8flnSkzGJz9q+kG
         iZjw==
X-Gm-Message-State: ANoB5pm9DSMeWFVb4ScrNWFWs9Ga5uVPzb/1A8u2PqzwLwDAXgMoXq/Z
	X79UbJAwPb2uULbqbSvkrfTsLA==
X-Google-Smtp-Source: AA0mqf7l6hyi3tkM6jXVBjJCuc+8zgZBuonkkQGea1oLdFM+be1JnytRBOSMSNIP4RMW5LR6eCSQvA==
X-Received: by 2002:a17:906:fd57:b0:7be:5c6f:e63c with SMTP id wi23-20020a170906fd5700b007be5c6fe63cmr32904348ejb.253.1670235424059;
        Mon, 05 Dec 2022 02:17:04 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090630cb00b00781dbdb292asm6060546ejb.155.2022.12.05.02.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 02:17:03 -0800 (PST)
Message-ID: <9cf89ce7-a6bd-1ba6-d8b9-a9d824abbb87@tessares.net>
Date: Mon, 5 Dec 2022 11:17:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-net] mptcp: fix deadlock in fastopen error path.
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <21c1eac505e089b2628539dc5e4d9ab2ed1379f8.1670005632.git.pabeni@redhat.com>
 <e0f957f0-f990-d287-3430-921084869fcb@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e0f957f0-f990-d287-3430-921084869fcb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 02/12/2022 19:54, Mat Martineau wrote:
> On Fri, 2 Dec 2022, Paolo Abeni wrote:
> 
>> MatM reported a deadlock at fastopening time:

I can fix the two minor nits reported by Mat when applying the patch but
I don't know if you saw your patch was modifying the behaviour: TFO
packetdrill tests are now failing:

  - Unstable: 2 failed test(s): packetdrill_fastopen
selftest_simult_flows 🔴:
  - Task: https://cirrus-ci.com/task/6580586486693888
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6580586486693888/summary/summary.txt

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

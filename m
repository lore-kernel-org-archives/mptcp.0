Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B83217
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 17:51:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1616908wmo.1
        for <mptcp@lists.linux.dev>; Thu, 08 Dec 2022 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuSI1GRwY7idCBU5MPb1jLQgFR18SRt+E1ihyMXhI6E=;
        b=2yBAWRDbLfeUglCI3VdINpC9jTU7fX9BVS2ZPb2WbnxX+JpWEVxavJvZrlNbFcIG2+
         VpC+VvZ6EBT8nVURyq7jq0enYCFR/Re3muK4KbS4Gr/UoD8FDZlQOdixoUFSL0++f5/l
         N6qaAg4GYqeLqptGsrGSRRuN1dNsKLzRcUS7kA0o2daBZDbIpcWmQESmtXboGhzQHL+e
         qRSbDMIep7e6mIxfa7sKRPFm/f+EMvyLN8Xc4eT+KMtW7N7h8qaXXyxBgX+MieyeFeWO
         efdDdyEVAM3kU8yuU9hRAUTim7CFCY2odqr5vRVAuHdGovOAHpMAkIvUr9FlA6M4KcUB
         BlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UuSI1GRwY7idCBU5MPb1jLQgFR18SRt+E1ihyMXhI6E=;
        b=E776edQutzl0pzWTekN0xC/n/iWeGKXKEr4T4T7doKpMOvthcMglCVn18AQ64HHNu1
         KKOomwe3yr30MIDAm9/6+jyjtWo+903wszrYNnDud3zyZS8NDN79Cc5yBiracwtp/SsZ
         UyuqlFdJrt02j0ug9Uk2OP5UONfyfWrKyXA9PP0IHSJGLhp/Xs7LDoGuGUOpAR8RTv51
         1m5TX6g4D+hdARceR2WsaWdxfCoIMsmU/OiRQ3BEzq7RcmsY7zoBGHtCDvfJYZ4wGXhU
         VlO+8gO90i0BhIeDdjFVFkQ0KFpCNfhERU6qr/YjoHjVE7ekIy/8r5XqbErAFPyMVeFb
         HDdA==
X-Gm-Message-State: ANoB5pkg50J5Zs19WniYKUboTzTj/xBfxC2JfCalmQ+kpgioK21XnbKZ
	rxSjj8js4nEnak7quF2a6hH/x691k9fAJi1l
X-Google-Smtp-Source: AA0mqf4OzhhvRTd8cD8SkhUOrs9unyT+0iWLl5n84Bq+qsfSihphKaxbA3Nwtery27ghxEkWChFcZw==
X-Received: by 2002:a7b:cd8f:0:b0:3d1:baf7:ceae with SMTP id y15-20020a7bcd8f000000b003d1baf7ceaemr2661838wmj.39.1670521891000;
        Thu, 08 Dec 2022 09:51:31 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a52e:7e0:5ffc:6cea? ([2a02:578:8593:1200:a52e:7e0:5ffc:6cea])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c46ca00b003c70191f267sm6292946wmo.39.2022.12.08.09.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 09:51:30 -0800 (PST)
Message-ID: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Date: Thu, 8 Dec 2022 18:51:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [Weekly meetings] Change day/hour?
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Ossama Othman <ossama.othman@intel.com>,
 Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>,
 Benjamin Hesmans <benjamin.hesmans@tessares.net>,
 Dmytro Shytyi <dmytro@shytyi.net>, Christoph Paasch <cpaasch@apple.com>,
 Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

At the last meeting, we discussed the idea of re-scheduling the weekly
meetings we have because some people might not be able to join or prefer
another moment.

But because we were exceptionally only 3 today because of the feast of
the Immaculate Conception, we didn't take any decision. Instead, we
would then like to hear from people who want to participate to know what
they think about eventually:

- Changing the day to Tuesday?
  - It might be better to avoid Monday (morning) and Friday (evening).
  - Wednesday was not OK for today's participants

- Changing the time to have it one hour later?
  - It means 17:00 UTC (9am PST, 6pm CET, 1am CST)
  - This is late for people in China but midnight is late anyway
  - Maybe we can also schedule less frequent meetings at a different
time (or on request), e.g. morning in Europe, afternoon in China?
  - (the BPF weekly meetings are on Thursdays at 17:00 UTC)

What would be OK or not OK for you? Tuesday or Thursday, same time or
one hour later?

Thanks,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

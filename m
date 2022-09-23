Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91C33DC
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 10:58:57 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id y3so27156566ejc.1
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 03:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8ld12XDJNNBKl7550xGwmQbUE0j25L52+fv9XSPzVvI=;
        b=Uz40MdUMrPgbit/qwzjmYgVUd5joNW+QCUwtfzw9cXLk1CxAuF9WepEvz1qfjo6HQF
         ZcSE7DDiJ+joi+YIw9ANiGKqzAQr6HKtyjYlZW3zj61L8VLkkF7jOTHm78lEEtsueEuO
         3ktYnDq/Htg7lz9CVdwodlCIIcV7tIWZeHXQUEPzGZldWcxWWOj4AKQpOXwPlztaL4aX
         oQExg+Unr4/ZvFPlIJW16QFvxythr4RNs3sTjNfliLzEuC/uHP3WIe6t0gPqtUck/005
         10/gTof6DDylKawWNrzIIRQATTpSVY+laZguvMkGyAFl+qdUV8KX6FzjDHJ7l6IsAQfn
         8qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8ld12XDJNNBKl7550xGwmQbUE0j25L52+fv9XSPzVvI=;
        b=jMn6WmMQVjaHpxzwW2WdTmrlUUFcUqLXTLmWy7gQMMZMb9nfPKbo+RwUEnDstL/0u3
         lTjm3UdUFYyya3z2OahQDl4Qnpd+snkLYu4OsK/H6a2BJvfu81R1ZGEexWETeY+zQ9cw
         80Jo4BAlIjdHRNvIAtGWGt8POBfTLsqK5M6Gc6tkfLLOalE/Tp0/mSjAgLXy8Dc5m8Ln
         mrRu1m2qsKRELBWjf4cWUumSYEC8jDI+b5YJvUY7eMZvbj44Pj/AlyQ6mLlZtOYGCzvD
         1IBMPsBJ3S0wPs+0AC2oddNxHRj094D26UJksGYSOieYweJK4PwDgo8CbhjvpL8AlQfw
         za4w==
X-Gm-Message-State: ACrzQf1rfSsiYMcHMdUqLwkZauyfHCwZWgMFR7PvF5wjCe2gBq3odW1o
	1cY75Vcg6uHsAH0zMwJoFMPw+g==
X-Google-Smtp-Source: AMsMyM7MqdHyGmZWCkskBOcrDRDMfSKbteCfuZ7/+w065+r7Y/2up+y1vy1B5Zc2KAKzkq9auE/rGg==
X-Received: by 2002:a17:907:b1b:b0:772:1dcc:a512 with SMTP id h27-20020a1709070b1b00b007721dcca512mr6375336ejl.247.1663930735794;
        Fri, 23 Sep 2022 03:58:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5e2b:69ae:ba71:ae54? ([2a02:578:8593:1200:5e2b:69ae:ba71:ae54])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709067f1400b0073d7b876621sm3786060ejr.205.2022.09.23.03.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 03:58:54 -0700 (PDT)
Message-ID: <3d37f47b-dd2e-fe80-caab-d1863028d7f1@tessares.net>
Date: Fri, 23 Sep 2022 12:58:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side
 only
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>, benjamin.hesmans@tessares.net,
 mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220921125558.19483-1-dmytro@shytyi.net>
 <709a843b-b7f7-438d-39c6-f139aaa55a10@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <709a843b-b7f7-438d-39c6-f139aaa55a10@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dmytro,

On 23/09/2022 01:23, Dmytro Shytyi wrote:
> Hello Benjamin, All,
> 
> I excuse for the later if I made any mistake.
> 
> My thought is comming from experience with the patch.
> 
> 
> Will huge respect, I think this patch _*MUST NOT*_ be accepted because
> of multiple reasons:
> 
> 1. it violates the RFC 8684 [1] section B1:
> 
> "When a TFO initiator first connects to a listener, it cannot
> immediately include data in the SYN for security reasons[RFC7413
> <https://www.rfc-editor.org/rfc/rfc8684.html#RFC7413>]. Instead, it
> requests a cookie that will be used in subsequent connections."
> 
> 
> Also I created environment[3] using commit[2], I tested v0, v2 and I do
> not see the mptcp capable option in SYN.

From what I see in your setup, you set net.ipv4.tcp_fastopen:
- The sender has the 0x4 flag to send data in the opening SYN regardless
of cookie availability and without a cookie option.
- The receiver has the 0x200 flag to accept data-in-SYN w/o any cookie
option present

See the link below for more details about the bitmap:

https://www.kernel.org/doc/html/latest/networking/ip-sysctl.html

If you change these values, I guess you will see the TFO cookie option.

Please note that the proper way to validate exchanged packet is to use
Packetdrill. The following PR proves the implementation works with TFO
cookies:

https://github.com/multipath-tcp/packetdrill/pull/87

> 2. Abscense of MP_CAPABLE in SYN  violates the RFC 8684 [1] section B3.

The Packetdrill tests also shows everything is OK with MPTCP.
I suppose there is an issue with your test environment and some paths
(e.g. libmptcpwrap.so) are probably wrong, justifying why you get a 404
error when doing the curl:

  "GET /tfo.sh HTTP/1.1" 404

Please do the validation without mptcpize, e.g. with packetdrill:

https://github.com/multipath-tcp/packetdrill/blob/f3672b80a687e0e2a59926992f28c165783ecf8b/gtests/net/mptcp/fastopen/client-TCP_FASTOPEN_CONNECT.pkt

> 3. Patch uses an original Idea of another autor from mailing list (Reuse
> the TCP FASTOPEN option in MPTCP).

A v3 mentioning you is going to be sent as discussed at the last meeting.

We should indeed mention the authors of the original idea to have TFO in
MPTCP:

https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

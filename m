Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D71F183
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 14:43:00 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso7811845e9.3
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684852978; x=1687444978;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9YwIWma7O0kh1gSpJP4ikiXmr/GAQz3qIKp9/jLbv4=;
        b=usJHLJBOwSdAaMzhHuPLcAMOBNZrErNlRZIxPeDeBqFeUBXzvLEurNnr4VGzUtdZjf
         91QApxJZxBt+bJCEitNIDjRC6G2U+SaqXqmi1zCIax8vWuVr4C3ABVgSH0daY+6b4h8Z
         lc6ihGzXCEwida22ddySVQTQzq+lbbcKmHEWuiYjr2wGAESyzlD+xeY9ZNetIit2jT9m
         AEV1IgNKTmFYkeJJAEci8Lai9yTd2FwexBqH86iVc0lM+xzMZD94l38U8+xHpM9kVExt
         HDkmzMqn0dpkMI+sDpitU4Qkwf1HgVVaEy3zinFuxHhTODfGavzGMc+MKf0ICiyht0ma
         oPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684852978; x=1687444978;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9YwIWma7O0kh1gSpJP4ikiXmr/GAQz3qIKp9/jLbv4=;
        b=YqV8H/0jAeeW8wPtFQ/UG8y7EjQqzXFlV8BZrgClhFu2fTO7hrYk+JCDB/MqEM2bPZ
         q5vKmEp2/o8ztdk4Rhxesv1qWvlajk4J8dpxUDcQJ+gT+381jH9xG6A44hlGkaN75Zk0
         f/I2cFQ55ulgCSHlk7rrGsnEAzegUVrBuz7z+9IG9XTTq3uludYFni/ClwB/TtDQw/1q
         0fCE27A08MixX+LNUprx0hkmBMOqv+I2d6Lz8c94PEZn6YjcZMuruUQla9O3WurdGAR+
         fQr8q9z55psq5z2Pl1vXXkOujhaYn+opEd8I/Dg24+m2RElcr7oq7OBZIPxZKfD7r9eM
         TcHg==
X-Gm-Message-State: AC+VfDwISIxF7dzeylRzr5tO/206BDOJjzfT+SX2EwgFt7TP8B2QgiVu
	QHZ7aKk9AR1YdDG9rOk9V8N9IXPgtgJEEj7KKJDUsfsR
X-Google-Smtp-Source: ACHHUZ4fXkAOPlccs2Irt+t3Q4o3aA0KR9pnGcWoqC6uBJxIzELMWUM5wHr6BPgzg5cVmPhr8KUbBw==
X-Received: by 2002:a05:600c:2146:b0:3f6:4f1:cfbf with SMTP id v6-20020a05600c214600b003f604f1cfbfmr5083468wml.20.1684852978451;
        Tue, 23 May 2023 07:42:58 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d670a000000b0030903371ef9sm11387975wru.22.2023.05.23.07.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:42:58 -0700 (PDT)
Message-ID: <21beb72d-9be0-85b5-ac26-76654c559194@tessares.net>
Date: Tue, 23 May 2023 16:42:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v14 0/5] update userspace pm mptcp_info fields
 part 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684760588.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1684760588.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/05/2023 15:11, Geliang Tang wrote:
> v14:
>  - drop mptcp_pm_remove_addrs helper in patch 1
>  - add two flags in patch 4, the address entry'll be removed from
>    userspace_pm_local_addr_list only when both flags are set, by doing this,
>    it's now independent of the order of the remove_subflows command and
>    the remove_addrs command.

Thank you for this v14.

Please see my replies and questions on the individual patches but in short:

- Patch 1/5:
  - Maybe best to keep the helper. You can also modify it to remove just
one address instead of a list of addresses.
  - see patch 4/5: you might want to ignore the returned value of
remove_anno_list_by_saddr()

- Patch 3/5:
  - see patch 4/5: I think you can remove this one

- Patch 4/5:
  - I think it is better to use the version from v12: if the userspace
asks to destroy the subflow, we remove the linked address entry (if not
used by another one). So yes, it means we cannot send a RM_ADDR after
the destruction of the subflow but that sounds OK to me. I don't see why
it is needed to close a subflow (send FIN) and then send a RM_ADDR
  - Or am I missing something?
  - (if really we want to send a RM_ADDR for an ID we don't have, we can
also create a dummy entry just to be able to send the RM_ADDR but
currently, I don't see why the userspace will need to do that).
  - compared to v12, please:
    - do not call mptcp_pm_alloc_anno_list() (+
mptcp_pm_remove_anno_list_by_saddr()) from mptcp_nl_cmd_sf_create()
    - and move the comment above mptcp_userspace_pm_delete_local_addr()

- Patch 5/5:
  - first send a RM_ADDR, then a destroy subflow (or adapt the
verification we do not to expect a remove address)

- Patch 6 (patch 1/7 from your v13 part 2):
  - please add it to this series, it is also for -net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

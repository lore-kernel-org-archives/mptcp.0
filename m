Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198EA922
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 09:38:28 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso1497044f8f.3
        for <mptcp@lists.linux.dev>; Fri, 01 Sep 2023 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1693561106; x=1694165906; darn=lists.linux.dev;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JYjMFr0rdwXwhzGIgYo8ROTqF4A7wv+QzfhIX6B0p0=;
        b=oTMzRU3AWLca8itTHjfoZu0WNZgi3dszD6OP4qa7ubkSBDs+sYP2ZG/IJXbyQ8j2aG
         c91Z2pvGVmIxRIusKwrG2faxJ8H8W/EEimKAtPjZUvDe5xf8LkoFEGt/uqbDm+xRgo5b
         UyyZ+sNhUzjZXhji1lFVLgVsDq3qHKgCtwRINB1lArJddN5YpAkrgQWQO8tFDkhXC+ye
         v7WlxBbb3sbngJvQnmyC1aKBAAu/4poh2DjkSMDs8laHxWUddz8AF0QwBXCLe1uxpd2a
         oHqjUdpzvd5uu9Oj9wa99zc/X2rLbXLzQyPj7BYyXi1WJf2YtvqCcoIHcv2PV0+Vp9OX
         n1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561106; x=1694165906;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JYjMFr0rdwXwhzGIgYo8ROTqF4A7wv+QzfhIX6B0p0=;
        b=b69rfNgJDn4mOt8Sz2jkVmUeFaHBvXB2zhFWd8WcZ2OfUcmmkRmrMUC0N+B2prg49Z
         tRRhSzsKyMnAAVdsqfDrJEC/UnJUe3EHT+m5tq2t4FBjTAKL7Rd0IE4XDp6CwUES/6+x
         /1Gnvd4GJhtI9O+NlSVSoWtkoShzOffYIwNdYuuIt7fn7I/aVt2b8oYPL3gkJG3JLXun
         OX5cPrtS615t1C31wLkofbb419RT1JvBrnUdJpz6e54Tw+01OsmQxi0xabuICHgJfsaj
         GGkp2tseLpMih0cB8/utPAyhIh9vaOn4i4pwGqHrZGryOUWsW2oMi9TkXK7oBYPHflKG
         PDsA==
X-Gm-Message-State: AOJu0YyaMDmj6yakNgOD4oDDd0vvoEyFzLodyk8X9HqnCLH2LGpxF1jX
	+LiosGLmr9OUpdMH3clrDGRTagly62qLohrgnu1EqA==
X-Google-Smtp-Source: AGHT+IFgclVneW5z7+TCbPWRweU3dCCR+jw34LLp62Z6tmVVodXPRvviUfXcE5ZC1svEgnwLh04uuw==
X-Received: by 2002:a5d:424b:0:b0:317:3dff:7189 with SMTP id s11-20020a5d424b000000b003173dff7189mr1467351wrr.66.1693561106229;
        Fri, 01 Sep 2023 02:38:26 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c4-20020adfe704000000b0031c5e9c2ed7sm4660549wrm.92.2023.09.01.02.38.25
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 02:38:25 -0700 (PDT)
Message-ID: <18f1ff87-77d8-4c41-b8ea-afe638d39789@tessares.net>
Date: Fri, 1 Sep 2023 11:38:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Public CI: some changes due to Cirrus CI's new policy
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzS5NYXR0aGlldSBC
 YWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ+wsGSBBMBCAA8AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgBYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJhI2BOAhkBAAoJ
 EPa3gk9CaaBzlQMQAMa1ZmnZyJlom5NQD3JNASXQws5F+owB1xrQ365GuHA6C/dcxeTjByIW
 pmMWnjBH22Cnu1ckswWPIdunYdxbrahHE+SGYBHhxZLoKbQlotBMTUY+cIHl8HIUjr/PpcWH
 HuuzHwfm3Aabc6uBOlVz4dqyEWr1NRtsoB7l4B2iRv4cAIrZlVF4j5imU0TAwZxBMVW7C4Os
 gxnxr4bwyxQqqXSIFSVhniM5GY2BsM03cmKEuduugtMZq8FCt7p0Ec9uURgNNGuDPntk+mbD
 WoXhxiZpbMrwGbOEYqmSlixqvlonBCxLDxngxYuh66dPeeRRrRy2cJaaiNCZLWDwbZcDGtpk
 NyFakNT0SeURhF23dNPc4rQvz4It0QDQFZucebeZephTNPDXb46WSwNM7242qS7UqfVm1OGa
 Q8967qk36VbRe8LUJOfyNpBtO6t9R2IPJadtiOl62pCmWKUYkxtWjL+ajTkvNUT6cieVLRGz
 UtWT6cjwL1luTT5CKf43+ehCmlefPfXR50ZEC8oh7Yens9m/acnvUL1HkAHa8SUOOoDd4fGP
 6Tv0T/Cq5m+HijUi5jTHrNWMO9LNbeKpcBVvG8q9B3E2G1iazEf1p4GxSKzFgwtkckhRbiQD
 ZDTqe7aZufQ6LygbiLdjuyXeSkNDwAffVlb5V914Xzx/RzNXWo0AzsFNBFXj+ekBEADn679L
 HWf1qcipyAekDuXlJQI/V7+oXufkMrwuIzXSBiCWBjRcc4GLRLu8emkfyGu2mLPH7u3kMF08
 mBW1HpKKXIrT+an2dYcOFz2vBTcqYdiAUWydfnx4SZnHPaqwhjyO4WivmvuSlwzl1FH1oH4e
 OU44kmDIPFwlPAzV7Lgv/v0/vbC5dGEyJs3XhJfpNnN/79cg6szpOxQtUkQi/X411zNBuzqk
 FOkQr8bZqkwTu9+aNOxlTboTOf4sMxfXqUdOYgmLseWHt6J8IYYz6D8CUNXppYoVL6wFvDL5
 ihLRlzdjPzOt1uIrOfeRsp3733/+bKxJWwdp6RBjJW87QoPYo8oGzVL8iasFvpd5yrEbL/L/
 cdYd2eAYRja/Yg9CjHuYA/OfIrJcR8b7SutWx5lISywqZjTUiyDDBuY31lypQpg2GO/rtYxf
 u03CJVtKsYtmip9eWDDhoB2cgxDJNbycTqEf8jCprLhLay2vgdm1bDJYuK2Ts3576/G4rmq2
 jgDG0HtV2Ka8pSzHqRA7kXdhZwLe8JcKA/DJXzXff58hHYvzVHUvWrezBoS6H3m9aPqKyTF4
 1ZJPIUBUphhWyQZX45O0HvU/VcKdvoAkJb1wqkLbn7PFCoPZnLR0re7ZG4oStqMoFr9hbO5J
 ooA6Sd4XEbcski8eXuKo8X4kMKMHmwARAQABwsFfBBgBAgAJBQJV4/npAhsMAAoJEPa3gk9C
 aaBzlWcP/1iBsKsdHUVsxubu13nhSti9lX+Lubd0hA1crZ74Ju/k9d/X1x7deW5oT7ADwP6+
 chbmZsACKiO3cxvqnRYlLdDNs5vMc2ACnfPL8viVfBzpZbm+elYDOpcUc/wP09Omq8EAtteo
 vTqyY/jsmpvJDGNd/sPaus94iptiZVj11rUrMw5V/eBF5rNhrz3NlJ1WQyiN9axurTnPBhT5
 IJZLc2LIXpCCFta+jFsXBfWL/TFHAmJf001tGPWG5UpC5LhbuttYDztOtVA9dQB2TJ3sVFgg
 I1b7SB13KwjA+hoqst/HcFrpGnHQnOdutU61eWKGOXgpXya04+NgNj277zHjXbFeeUaXoALg
 cu7YXcQKRqZjgbpTF6Nf4Tq9bpd7ifsf6sRflQWA9F1iRLVMD9fecx6f1ui7E2y8gm/sLpp1
 mYweq7/ZrNftLsi+vHHJLM7D0bGOhVO7NYwpakMY/yfvUgV46i3wm49m0nyibP4Nl6X5YI1k
 xV1U0s853l+uo6+anPRWEUCU1ONTVXLQKe7FfcAznUnx2l03IbRLysAOHoLwAoIM59Sy2mrb
 z/qhNpC/tBl2B7Qljp2CXMYqcKL/Oyanb7XDnn1+vPj4gLuP+KC8kZfgoMMpSzSaWV3wna7a
 wFe/sIbF3NCgdrOXNVsV7t924dsAGZjP1x59Ck7vAMT9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

As discussed at a previous meeting, Cirrus CI is limiting the free usage
from this month (September):

https://cirrus-ci.org/blog/2023/07/17/limiting-free-usage-of-cirrus-ci/

We understand that they have to change it but as a consequence, I just
pushed 3 modifications yesterday as a first step, hopefully to reduce
the load and not being limited this month:

- cb993082cd3c: ci: reduce global timeout to 90m
  → It is currently taking max 1h when the build cache cannot be used.
    When it takes more, it is usually because of a bug, no need to waste
    resources.

- 80118c2c87f4: ci: switch to 2 CPUs:
  → We don't need more for the tests, we were using 4 because it was
    free and to accelerate rebuild without cache.

- 489e810ac24f: gh: upd: do that 2 times a week instead of everyday:
  → We will automatically sync with netdev (net and net-next trees) 2
    times a week, on Tuesday and Friday. So we would no longer use
    cirrus-ci everyday

This can be improved later (switch elsewhere, different trees, etc.),
but here is a first quick attempt.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

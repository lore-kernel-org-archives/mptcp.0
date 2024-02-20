Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463E65190
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429856; cv=none; b=I6nIDVpRQsPjikzsf2GvoHB3swTT4O0ol/cRFc1TQg5zFvXw55laFf7rTqAqoy+FiFpgR7Zjr/eBPndH7CCK0jWZ50h1g0wzaMWXiFJa1YTnPFdjoAw9p41kmlSc8/Dt+OGDTzI9oC9GAyff8S9/zaYfKpYRpIlIQON6KNDtm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429856; c=relaxed/simple;
	bh=UKLeVTBdk1jlpUL7jdbLeYFvJuuh07QcXfKVXPBAvaE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Whry3qJzSsi6YRJpYOojB5UmoH4Lyb3KoBxFjuTOsc2Zy5fpAFjrLKSpT6tmPplM/4UNtel7GBVgGQ6YZ8xn7rSs9R7DxKouh9qd0Ne2KPMvSHuqGvwRRw+CDf/53XSjrKBH6iz5yx+dxTEZCJ7bCzftI373uzlOmoTj2SETyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPQS5i67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPQS5i67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31B1C433C7;
	Tue, 20 Feb 2024 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708429855;
	bh=UKLeVTBdk1jlpUL7jdbLeYFvJuuh07QcXfKVXPBAvaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GPQS5i67yxyeF4mMRnU4zRoRTehPYSRUd3jmWCuTBoPtjbJpbYe53zocTJDe/CV9E
	 wSMj/qC8w6p/XZHHkzZe+z6t9S+S9dGDm2u64DH/+5wc/hNMf7cocgyvHvBYwl2g6C
	 /B5G0uwOrVGZFSK8EzAvjx6z3OGqFgQP63vYxq8vIhK5h3R38Eg5F0Ht3hqmCGLbyw
	 TWmrSxApdNHjYYkUg4UPDHfEfuRVSt9SK3GW8FULSqnSh4ZIfgVNjJXUGB4QJxo0WJ
	 WxWvnEyxXPAmmu+ps7jsKz3t4B58Nh5fCL6toWVJbqhq1zHGpMbTJyqORPvMEcsVDg
	 wNj/O0iSLGpPA==
Content-Type: multipart/mixed; boundary="------------gBSGccjaY06iy7OM7hExhE0J"
Message-ID: <682134fb-8893-4ee0-9ddd-c0a4a4f5650b@kernel.org>
Date: Tue, 20 Feb 2024 12:50:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v14 00/14] dump for userspace pm
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>

This is a multi-part message in MIME format.
--------------gBSGccjaY06iy7OM7hExhE0J
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/02/2024 10:58, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v14:
>  - address Matt's comments in v13.

Thank you for the new version!

I didn't look at it yet, but:

>  - I have to use these lines in patch #8:
> 
>       local cmd_ret=0
>       local out=$(${cmd} 2>${err}) || cmd_ret=${?}
> 
>    The following expected code breaks pm_netlink.sh, I don't know why:
> 
>       local out cmd_ret=0
>       out=$(${cmd} 2>${err}) || cmd_ret=${?}
> 
>    If this is still a problem, I'll send a squash-to patch to fix it.

Yes, we should either fix warnings or explicitly mark the false positive
ones as ignored.

Can you try with the attached patch please? It is not clear to me why
the second block doesn't do the same as the first one.

I can squash it when applying the series if there are no other comments.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
--------------gBSGccjaY06iy7OM7hExhE0J
Content-Type: text/x-patch; charset=UTF-8; name="mptcp_lib_shellcheck.patch"
Content-Disposition: attachment; filename="mptcp_lib_shellcheck.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9s
aWIuc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfbGliLnNo
CmluZGV4IGFjYTM1Mzc2MDA2Yi4uNTU2YTdkOTc4NGQ3IDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfbGliLnNoCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9saWIuc2gKQEAgLTM1MiwyMCArMzUy
LDI0IEBAIG1wdGNwX2xpYl9jaGVja190b29scygpIHsKIH0KIAogbXB0Y3BfbGliX2NoZWNr
X291dHB1dCgpIHsKLQlsb2NhbCBlcnI9IiQxIgotCWxvY2FsIGNtZD0iJDIiCi0JbG9jYWwg
ZXhwZWN0ZWQ9IiQzIgorCWxvY2FsIGVycj0iJHsxfSIKKwlsb2NhbCBjbWQ9IiR7Mn0iCisJ
bG9jYWwgZXhwZWN0ZWQ9IiR7M30iCiAJbG9jYWwgY21kX3JldD0wCi0JbG9jYWwgb3V0PSQo
JHtjbWR9IDI+JHtlcnJ9KSB8fCBjbWRfcmV0PSR7P30KKwlsb2NhbCBvdXQKIAotCWlmIFsg
JGNtZF9yZXQgLW5lIDAgXTsgdGhlbgotCQltcHRjcF9saWJfcHJpbnRfZXJyICJbRkFJTF0g
Y29tbWFuZCBleGVjdXRpb24gJyRjbWQnIHN0ZGVyciIKKwlpZiAhIG91dD0kKCR7Y21kfSAy
PiIke2Vycn0iKTsgdGhlbgorCQljbWRfcmV0PSR7P30KKwlmaQorCisJaWYgWyAke2NtZF9y
ZXR9IC1uZSAwIF07IHRoZW4KKwkJbXB0Y3BfbGliX3ByaW50X2VyciAiW0ZBSUxdIGNvbW1h
bmQgZXhlY3V0aW9uICcke2NtZH0nIHN0ZGVyciIKIAkJY2F0ICIke2Vycn0iCiAJCXJldHVy
biAyCi0JZWxpZiBbICIkb3V0IiA9ICIkZXhwZWN0ZWQiIF07IHRoZW4KKwllbGlmIFsgIiR7
b3V0fSIgPSAiJHtleHBlY3RlZH0iIF07IHRoZW4KIAkJcmV0dXJuIDAKIAllbHNlCi0JCW1w
dGNwX2xpYl9wcmludF9lcnIgIltGQUlMXSBleHBlY3RlZCAnJGV4cGVjdGVkJyBnb3QgJyRv
dXQnIgorCQltcHRjcF9saWJfcHJpbnRfZXJyICJbRkFJTF0gZXhwZWN0ZWQgJyR7ZXhwZWN0
ZWR9JyBnb3QgJyR7b3V0fSciCiAJCXJldHVybiAxCiAJZmkKIH0K

--------------gBSGccjaY06iy7OM7hExhE0J--

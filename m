Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24032B110
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135155; cv=none; b=NlBtjW1k9RIpjHQIgqzGgYplVGNSXpKZ2syfJ/awmQz/1/aYghpi8CIkVN3a9/RwSo8y4S9rSMuThXXt/sVjARwYA/gCjcyZQ3CtfeZ/sDI8pmEmMaNh84vhJtHPMuvehLR22gbiLS6Nu3OxK+SgEe+xPZBzwlremsxha8tVILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135155; c=relaxed/simple;
	bh=SZNJkYc3tkfDXW6WlSvsV2DyrfkRhtTK4mmHxO+/8MU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mz78xDACzHYPtOgz5t3haViF9uVOCL1CfThjCbhYLQSShfXjNKeWIWqVoUCeLT3fIK8PzfXq1OUXpyRc6o7LkwIfikFgg/viHO3CSjt9fP4/vbb4mAPbG1hJ4RffW43bV4Ug47zLYxFAT8O5FtvmpG6YYWlf7nW5lZ2T2ZRp/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv/B7Ez5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv/B7Ez5"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8266c388b67so5108767a34.0
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135153; x=1792739953; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BJM0bghpLmKEDCEhcdAxyFSTUzWF3kq3I8I/7XMYbTk=;
        b=Mv/B7Ez5mTlSIt9qOku2jvV28LsR2oTLk51+uUocZa7pzXqwKstE6wheNGcjunJ0l7
         HMWt2XZa2LUSPGxDGy/iCQ7QPQ4hGakQghNO86PSkUDEry2A80gkzAmhZaHkWKkdTm5r
         c9Nd+trLty4qo0ZbPSMsEWVUpetENgo+wZ5ubavBoH3BognSaCq7VScnFZFU2Fv6dPxU
         bq3McssoRzWPwzs3zwrC/SWa9x61kWeMSJNxkGTMxMFIcryB9SY8utZYtH/d7+QBirt9
         4AvGa8bEdVnW8L/wspsr5azDoVzIoZbPW6DcWYZqskNsTGVfKlL9lYvzxEJFmWt3jj9G
         LIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135153; x=1792739953;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJM0bghpLmKEDCEhcdAxyFSTUzWF3kq3I8I/7XMYbTk=;
        b=kWsYPAyTUnUfOjEJweWbPEkCfR8wXdWQ9jASnxaubY9efi75PvogbeWmcNbTukQDAD
         CIeQm1zZmh/y16YYUQ5rQw0FRty87DhvAWR3+RjfG4+I+r4qs5nRlueBnEqRqOj6H4Me
         rTA5fQZE5X6jltFAEFfvw2vXjST3Rhn42vs2jlX8Vi3ZcSpHBEbB/gepMHYpZwX0YBys
         SoyS6l0z7+OEpnjleerpyHqSgZSVKsT73jWlNz1GjLQYTKnwl9ggs3JgbYq3RLGNleuC
         FaFDTTr8YAnA9T3GK7Hmqn1lxAXNwjiKJYXHTyT6+2MOb093sQ0AZV4IBY0qJxx8M8aS
         +/yg==
X-Gm-Message-State: AFq9FYJF2QjNWrV7fe0XziAWsYE00QjxFxg7Aj8XYNB92PA9aXXFygNN
	Q59254fxO/YiFHNWdoFZa+qNYUZ+BQqFdnMWDZKU+QL42IZmMB4Pi+qt9CMRCEA=
X-Gm-Gg: AYBFou2xIFPKweS2rdfkJ7WnURTiHiKjsquDvQTUNMyoL+R6upFeFnaQXUYLRXrpM3T
	y/QyI5wZI28jrwOo2JbluAe6c4j2qSqoe5sYyzTixWfMNPcKJ64jB3WaCMGnhv/8sYeYRD0/abZ
	C9t9QNa04j1z+akC0NHaK9m0RJRdg1wioC9we6Fou5tmDA07Z/JQQEv8mcRof7Z3imf7EZvkd1q
	ZOS73dVQxdq+sORG0fQELSl156aSkntSzeoph2M8moMvEMHiu6LFtI8Rrs1Mmm8RfXL5Z8yaBYR
	cqfcAllY6kZYnnXDGseN2MWeammtG8t2qDIhLgEVVKF1czWvsvRaPMV0YyJ5077YpgZcCexgLE5
	JyFW/rbKf6AMte5XNmz3WvufYRJAbPtyRUG8zjatiDfyrbRjX99HmqZIWvuAeaqOLa3DVixphdH
	SwXnlWTN981KueFUJcgfhK9VrgGoR80u1onmxHnIA/rnJUEovB0oTeut1OJjiR/mFCTGAaytGAA
	lrCnfL3GgV8BA==
X-Received: by 2002:a05:6830:270d:b0:80c:d34f:5f63 with SMTP id 46e09a7af769-8309814be28mr20294610a34.28.1792135152670;
        Fri, 16 Oct 2026 00:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([128.203.190.81])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6f0a55csm1231938a34.25.2026.10.16.00.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:19:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/3] mptcp: pm: kernel: retry subflows
 closed after an error
Message-ID: <b1c946d9-43fc-9a28-63c0-3d577a43460f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:19:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/388598=
46683

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/29a6a3b28517
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186977


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)

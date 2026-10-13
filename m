Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF837B41E
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864687; cv=none; b=HVJ/1X36WPNPylyJeEgf4KbD2OL8pfahqWARxlObhVbS7hODphr5zAK7bNpSFzgPZKHRdG/Y73Xhjj5l5t5kpThsEnlr2HVNDx3QAAiom+f8tyRWmft67ie/3OGvjPdYmxKEPbMwSQLfUtmPEVQVsSmevlsgi2TCXnkl26NrtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864687; c=relaxed/simple;
	bh=g31ICTr2GZuMsZfjwNC4r3Z96XkAtOqkyeg7xQdYoIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=F1xDJj/D+5wnxZ8QIB4SaafLfRwart+ndZYgfJysJgDhsAPqr8O76IqyFo59oQMcBxFtn8Jcebne62Pm5gZfGmXOvJA97Cahwib8h8L/pblZel5OvFxENm9MWiRihhMW1UgVeNxJpPP9ScsYIwptrgefIYZpvl0Mueiy/bS5BLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBCcbcrO; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBCcbcrO"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35b2c599f43so1185624eec.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 21:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791864685; x=1792469485; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qB1DlGKYmuM/H33OlNv/urEOhdkJ0xrrB8hopyHfKZQ=;
        b=iBCcbcrOCCsoOriJo8SGR/GrEHcAc0nm3oAShTN+WUtKLSMadnzGoVi3h6flYVBXjx
         LXjUZ7GxkVrRo5YaG7RN3k/mV6rrvUz40HfSPuTJ61PV3ut5LSVawldBbY9R3CdTJWF8
         JRMjALKy0vClb9jXEH7RMg4wIFJbsfhRGq+1JlcY32CP9NekbbujOKXIkEOoQOmAa7sX
         LjOdkwwHY1KyHurz20fYSSluAZQTBjlRO47hPdRP73L/BWYYzR4RcCOy9Y/vGZuS8ivS
         eZ2TDqYY5Pj10HLPodKNdU7XhUmt+9HvnPJBhFQ7UoLoQvM13l2oHq6Z9u+j6omP0Qtc
         RVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791864685; x=1792469485;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qB1DlGKYmuM/H33OlNv/urEOhdkJ0xrrB8hopyHfKZQ=;
        b=X8wTbT79vyMuseI+8TwGqjHKBtu5plq0r+uFPiy+dInLDu9Fz6E7wLBDWUINXbgxf8
         Vi3VkUqHqas7FaHhA9qrFroh2/0YWlbRh9IsZojy27tLHZKSmXNUo0qcTA/97MFHAmaK
         2nRYITU5TqPAPDl6S6kP7h6VL0LjNiej33wswqoDxotsjAlmdmYR1DAX5iYUiDzSx/al
         EVfiAVFLRb37mmV3NYx4C8/08zBFRh9BvjrjE7bSQllF5Yuc1nI6Roh6Mh2gcpAzjpI7
         vNclB7vssniQcZHMi3HIrWWHQiGHB09bc0U6/CNxAZTY+zKP11e9ucRQ/oPbc7oJzPdp
         9t1A==
X-Gm-Message-State: AFq9FYIi/uLdHrItyINnbnVJH7JjKOSp+ni9fJLZQQKGm293yNPF6cQi
	oDvRMgXR+bXQ8/UK9Zb7uzEG7KBljNbuHLCSce7sVLC+ZjOZ6WWpXrk=
X-Gm-Gg: AYBFou0ZqVFPTSHARHpaUJMWJoGnVIBVC3lIOTcozJJbNhsmFn0rrIcug5PSRryQ2uP
	CHooIAppOisndYZYo9tLxFSEpzV9cXW6b1WO9tedpJrKMQQeGhagKa/XzIEUJl14tncKLMNCqWs
	cIxLnlIluolZzUamOrMXrYcxvg+Wv8H9JV++EXmrG0XmBLfAfQpbZxB1emKLLQ1giJ1x6sX8nSn
	iC0nsy5znRMQlKdC4tKzvb/FCdAnx/8EC+OM80FedZZ4ZTnAMNEHDF/ZhG0k/1Bfb0foPs0QyrY
	MN9arwRuLrdm3FfxWJHBf5tpahgCgKyDLFSKcBdvwQPnUWue8MIkrPs6f9Tjq2GctrYWqsEEKr+
	d3bfPMDbAW+qQLkApm5FWTs9zkNh3tHedpM7YOdui3NauW8f4hO9rdEzz1hRko1ERzbbiIQnxSj
	3retuBVIV0t+TRbhCRLx9gXzA+SC3PfY4WwN0WVAg61yLg8UAADpgB+1WLX6KzhxfWSHJ47sOyw
	N+Qupmr2A==
X-Received: by 2002:a05:693c:62cc:b0:351:6f5c:5d16 with SMTP id 5a478bee46e88-3537e007cf7mr16875618eec.22.1791864684664;
        Mon, 12 Oct 2026 21:11:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.2.200])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm17167845eec.11.2026.10.12.21.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:11:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
Subject: Re: [RFC PATCH mptcp-next v2 0/3] mptcp: pm: kernel: retry
 subflows closed after an error
Message-ID: <0dae1e9f-d17f-646f-19da-e2fa13040bad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:11:23 +0000
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
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38341335050

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/067b2bf37c=
b1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1184306


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

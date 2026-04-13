Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FE35AC11
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092157; cv=none; b=nVsXXj+CC0VZp6/feD+Th5+Z+e7X3HOzdi7HcBIGHaMiz0ufsiq8Os7QutXnwxPRi0FFJj41YYYWlqDnDe/cJ0kzkDsCMGnYZm0FxgGFAeK/ubDaHCJk5wP5F/KXRoFUP8gonPUSV/9TcywL4xkDo5qwGKT6ln6p7O/gO2YDlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092157; c=relaxed/simple;
	bh=yAtVF0bX0CQAicXIFo5sYfW9XQnbAH6kzrOFuTrdtiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=asXLziyxXMmiG5UIjz9oygaI7dA3cql+og1Jt47cwoqOTJB+wXonswGGL0RT6xhni1Uuq1Q0c3qFuXudVl9yhwy6yEcMGB+1Auw5JlPWlazPAHw23hf8j9T34k/wzgViANqHbTc3nO379cm7xgm77AN7yqTZPwNbkWYlXue+fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZdNEu8M; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZdNEu8M"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfdac74050so463774785a.3
        for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776092155; x=1776696955; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMTCyfJIzQbOeXk+3I51aI09XeHlsu33an+G5JP7XI0=;
        b=UZdNEu8MAEb4ol53ntC/0WumC0ij+Avs60wfD0U/11tNVs2Hfpxk4IizAf6EX/JBZ+
         rPuv/wHLwUtdOLDHw8YAQY1kp7w7T7EtjXoUfmVe9yPpvK7jFHQx0a6IOi3ABshYvW6s
         8fmBkVBM41jKiQYv9nmRYRM2lCbAf0rWdLF7vdSnb2sWK6N3I+fBIs0kLFIsm3BQWbEa
         d/uILMzN4ftTt9q5Mt0ED6UYH4CwonwjtD0T6McKoM2AlRr4bShX6r12K0jRK9PYvz4M
         RT9X5Ao3N3GOcw9ACMHkzSkiyDj+wv4gUDhHdLTAudMbgQc900ymQ/ieAX9OljSnNwP9
         hoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092155; x=1776696955;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMTCyfJIzQbOeXk+3I51aI09XeHlsu33an+G5JP7XI0=;
        b=h6B/cJJ9kTXXDphN9Z5/3X9LjidYagKZ7Z6I4Y1bAQqoTB99ipMEGzAHRTUtkJ1WFP
         2V1p1blfx4gg0O4G1QbGD83JUQmMJYNDbmv892NXHzq2V2XuwNGXwJHkRW3d8vRp8GtN
         t1Fey/6ZAaq6XopxSAHra+PieBvBNxgUbSdQv8V+RoQWa7/yM0DD0pPwTs1uGzu7jciu
         ZODWWSqr3B2wzpvS7Oby0bmoTbc9caWL1mupB10rxBiN3qGXizFzPXU6oN2LaCnmQ6hA
         1V0HAnbZ+D4jU7rAta0shjyeNY8ppvQqrV534tFiiQPs2cVPs7N+IrPTSzF+8JyzEIoB
         Aq5g==
X-Gm-Message-State: AOJu0YyKiLKp+M/6zlnbPEIp5jYWRD4tOP9g9RTOdw2/JQSpkkqPyP/B
	31gEqKOqd2HpigHxEbW8PvOVHAc7brNDCQJHgk3XYSUyF5UAwKfP7/WqVKAr
X-Gm-Gg: AeBDieuBTl0LvE8xlBWhFF87KaARidsHnE2h0HUUs5iG/1H6z1NLElAuIPZ/seQcwHF
	vjB48Eb0afdzWV6GnHXhNwO7lLpih4onKB5uMsN66Sn6BbmJa9djHNGtk8vW0AMtKIMztxMks1Q
	XYWsQcJN8QF8KEgWEnIR/8nzP+c6zR2Xge2ioU+KOaJkyihCRpkAkSulB7+qzOrnPa99R6qgcnR
	VWAIodKBAfsefAtJhsDPmnP6xYFpmDi1qa/kC7TshNQhnfQBgDP/NtVm1C75whhNszWpVGFxK5i
	ae9N6z9Ruso8uPB0gYGSiC+gclfk08/8rh/X+T+s8FB37LyntHe/OsMW+ym1TPGKzpI0CodgVBT
	ORH4cMuVzy8HCgjfjT63dtl2V683G+K9oofNa1+6d4kNSt2TYY7KQN1xlUrVHDDILFa19kEm6jG
	SsYrQzIC+5fCus11b/C7wD1peMB1nbVcHE2odggPs=
X-Received: by 2002:a05:620a:40c9:b0:8cb:4dc4:61d3 with SMTP id af79cd13be357-8ddcf9aa01bmr1989094085a.45.1776092155383;
        Mon, 13 Apr 2026 07:55:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.196.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88c82sm845974785a.2.2026.04.13.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:55:54 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
Subject: Re: [PATCH mptcp-net v3 00/19] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <58b22bf0-aa9e-5e21-3cca-90ec78b11019@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 14:55:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/24349397805

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/dd=
49feeb5952
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1080761

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)

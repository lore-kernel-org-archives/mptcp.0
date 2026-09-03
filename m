Received: from mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2137756F
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415981; cv=none; b=gPQmgpiBPw1OqBIirdwOPOS6s+bJmUhSSDHTSJ3oiqBuunJx3H5rUfg7Jx0xeNPkBSVEbCLTb9oDcI31WKdQavZLqOJdQpaES9WDx05CjvzSdB8T103KMosX6xlpdfCP2+r0fz4V9IxFh/+UfYkB0CrEMVaCEjOjsFO08k2wIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415981; c=relaxed/simple;
	bh=vo8acPN+MKdT2hP5RKFwCj4cE7JvOmAAM9XqO+/t1lQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=VMcnr1ima7tBqDWbLDErGU1PGO3Brp20kkoyiOjP8KvKafQQgYbOKq/7O1LjjzmILRnJhaPVFu8YIFl8NEmHEw8e46rWYE00mnplQAoff2zT2XpcOlSuRRNN9lHYo0VIG5JwK9l4ZXSDK077TI97EUXGIG+pkLIHgq908aGa9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LCSl3r3B; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LCSl3r3B"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=vo8acPN+MKdT2hP5RKFwCj4cE7JvOmAAM9XqO+/t1lQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788415976; v=1; x=1789020776;
 b=LCSl3r3BekhI+lbhdVY0wI3tTo60/jNe/9bN2r3WH20qR4RYBmgHyD6j9mwRWEFr7z9UgLx6
 iZcNtK49vC5l0Vc/2I4qbe39TI6sOLtSprNQl3Ve8sNhyZptiFz8HdMCRmvmN9fk5n9nfMS/1O1
 jO+VQSjswiJx5vXbG+pt76JI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e545c52cf7e68f0b;
	Thu, 03 Sep 2026 06:12:56 +0000
X-Mizu-Trace-ID: e545c52cf7e68f0b
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 03 Sep 2026 06:12:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
TLS-Required: No
Subject: [RFC] Mitigating Sashiko-driven iteration noise on the main MPTCP
 list
To: mptcp@lists.linux.dev

Hi all,

Apologies for the extra email, and please don't take this as any criticis=
m of the current workflow.

I'm writing this email to see if anyone else in the community shares some=
 confusion I have
regarding the use of Sashiko=E2=80=94specifically, the multiple rounds of=
 iteration and the large
volume of emails generated on the main list.

Let me explain the problem more clearly.

The Problem

  Since Sashiko was introduced, it has greatly accelerated patch iteratio=
n for contributors.
  However, from a human reviewer's perspective, the main mailing list (mp=
tcp@lists.linux.dev)
  now carries a significantly increased volume of emails.

  Specifically, Sashiko's comments are almost exclusively directed at the=
 original contributor,
  who then submits a new version of the patch addressing those comments. =
But this process often
  repeats for several rounds: each new version triggers additional Sashik=
o feedback, leading to
  multiple intermediate patch revisions being posted to the main list. Th=
ese intermediate versions
  are only relevant to the contributor and the bot=E2=80=94they do not re=
quire immediate human attention,
  yet they clutter the inboxes.

  In other words, the main list is currently used as a live iteration san=
dbox between Sashiko
  and the contributor, while human reviewers are forced to watch every st=
ep of this back=E2=80=91and=E2=80=91forth.
  That seems not necessary.

My suggestions

  To decouple the machine=E2=80=91driven iteration loop from human=E2=80=
=91driven review, I would like to propose a
  split workflow:

  1. Initial submission (v1): The contributor sends the first version of =
the patch series to the main
     list (mptcp@lists.linux.dev). Maintainers can quickly glance at it t=
o filter out obviously invalid
     or low=E2=80=91quality patches early.
  2. Bot=E2=80=91driven iteration (v2, v3, =E2=80=A6): For subsequent ver=
sions that only address Sashiko's feedback,
     the contributor posts those revisions to a separate, dedicated list =
(e.g., mptcp-sashiko@lists.linux.dev).
     Sashiko watches that list and provides its feedback there. The contr=
ibutor can iterate as many
     times as needed without bothering the main list audience.
  3. Final polished version: Once Sashiko reports no meaningful comments =
(or only false=E2=80=91positive warnings
     that the contributor has already handled), the contributor resends t=
he final, cleaned=E2=80=91up patch to
     the main list for human review.

The Benefits

  I believe both sides will benefit clearly if the sashiko process is mit=
igated:

  1. For reviewers/maintainers: Their main list inbox will only contain t=
wo types of patches=E2=80=94brand new
     submissions (v1) and "mature" patches that have already passed the b=
ot's checks. This drastically
     reduces noise and allows them to focus their limited reviewing bandw=
idth on patches that are truly
     ready for human scrutiny.
  2. For contributors: They can iterate as fast and as often as they want=
 in the sub=E2=80=91list without feeling
     guilty about flooding the main list. They get a "safe sandbox" to po=
lish the series until it meets
     the bot's criteria. When they finally post to the main list, the pat=
ch is already in a much better
     state, which should also speed up the human review process.

I want to stress that this is not a complaint or a demand. I fully respec=
t the work that has gone into
Sashiko and the current process.

Looking forward to hearing everyone's thoughts.

Thanks
Gang

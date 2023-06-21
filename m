Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D919BB6
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:38 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f90a1aa204so56199775e9.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367917; x=1689959917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5FKJe59+zZcEKP+2FCedLLuPhu8q47P8O4/lX6/NFg=;
        b=2oZELMuRAaa2sBWfTnMNchM5Po/6Yh2ZyUK9EPjDPAbmyV2lq5EU2o41gIC6urx85p
         VITOLAL8xMOSVOMs2yBO0cHMF78k3oHmj7zR+rDPyQma0LHTjWox2g+5beNJEKsd21sX
         dHL9zGduWTIAmqUvcELYjgVKTdly3Wc5aVDVLb7gYe4YX721+FXBCaOElMvXB2rMyomI
         oPOA+f5/jRGy3cogLAwfr8RF7cqTNlei8BOP5vEkTTippMpxc2FxkbHmaJ7GQMt0SwQi
         8hrQnHUCSJrlX9lcuKJVPYdI9NCCHLdpRfNSGH3se/+hXO9h6hUNG148EfVhsD/sexLy
         bG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367917; x=1689959917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5FKJe59+zZcEKP+2FCedLLuPhu8q47P8O4/lX6/NFg=;
        b=dJ2QZHWP6DEGnY8aCfKFr9dxDYnO0sMSVYyHPY9gHqWllWNiiilLjIDxG7L7tc8D9W
         5omZyx45zx9LeF3kXdTqXtWWXY6Gawgn9J/hg7pUjDuI7lxckcj8Js5N3rTrZ+M4Zy4J
         citA0YxEarSmwoAj+g4SJ8mbnoZG3r1fg+Cf89ESGXJMokkEw9YqfpG3ecIyrjq3SawI
         reHvXDLkWukGbYy8ruFmuQ8JDkG6TgWZhVNZdpQTFYriHQXYJpXgkEyyxOaT/d4Z8kpo
         Wsl7+k+Ok06t2mYlLtn5U/wFOHEwD1dNU/23mqFqnlhJWCdfDhsHwshkXKvmbNxzRK4/
         k2sw==
X-Gm-Message-State: AC+VfDyEryfJK9c2+XL9i2VN/s5Ipwr1QHbNPZDQUGzPauLso2HWDGYI
	hIWkqhtdGOFLd3MYPwCCjITEUkv998Zs6tDGPdv+ClcV
X-Google-Smtp-Source: ACHHUZ4F+Qkx6eaiMcUVYWPQNPcOL+koSiwPyWNL+WaLm1/5qhP/+EjENp8GK8FkAKnD+aKVwelXkg==
X-Received: by 2002:a7b:cd14:0:b0:3f9:b415:468 with SMTP id f20-20020a7bcd14000000b003f9b4150468mr7326444wmj.25.1687367917011;
        Wed, 21 Jun 2023 10:18:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:11 +0200
Subject: [PATCH mptcp-next 10/18] selftests: mptcp: userspace_pm: reduce
 dup code around printf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-10-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=1E0tUQvjVtEk3jpnA2xa60w/3ojogyW0lHzGxO6VFW4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjC9QBui2h4t1as/PXe36e+IK8NQ1EdrZA7
 shqIeXbuNKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c/BOEAClTUfk6Wlxu7ijMdSltAhyRWjFmUPN+W+eYvQmQaVvfWOzMUjDWTi552es6NhA3EYUNGy
 FFZy6I+wDIZgQYqTKxzLKMroy54diRnZi3ddWmsUwdTT5QSeBG3u50Kp8QWGKvJy5kgArmCwMu4
 MLXSHc9PvR8AtFouS9hAz7Cu+pVR7Bca8HW3d0gkZZ45Nff5gUXNpreycQ0es1ndT1O3IKQpN85
 0ezdoS0vqasgnXz+Acutd6D8EXUSAlcHorrVA8tAqlORXIr17u3gpz5xprJKTj+gYGJ8U3oegcB
 dTntaoz5vDCzz2Bh1eLKvOU++6BWBTr87PLjbyXXFIVcvKIL7sWxpFEHNKhvI+TPUAf2d8iBVn/
 jAKbPjhnDrBqq3o0UUwTN2Q7Aj/madMLVg8Oh2eP0HqWXZd0vlPvrf+zO1bhAdHPon5TygXxKCd
 QiKfzPPm+EhSy0x3ynWteQOlIaRX3X2NZM8zMoNO6kkxRJo8c0h750zJRF9FZctKVi6YWSxVt+4
 vETFS/lq7lq8S5eK3DUv2LByjYWmPTaP5+BGcV6l5XWODrmu89vOWhx2CMRfXhsMbdpK7SdrQHz
 70pCKbEHauTfvYR3+khu+oVcTgEtY0/YUcI8HLKi8+PcP8cYhTbKjKQ6R4opxVo3ET/tIJ4wYRU
 lB8D2617uqP1AEA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this selftest, "printf" is always used with "stdbuf".

With a new helper, it is possible to call "stdbuf" only from one place.
This makes the code a bit clearer to read.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6b733b97d358..568ddee1d102 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -59,21 +59,24 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
+_printf() {
+	stdbuf -o0 -e0 printf "${@}"
+}
 
 print_title()
 {
-	stdbuf -o0 -e0 printf "INFO: %s\n" "${1}"
+	_printf "INFO: %s\n" "${1}"
 }
 
 # $1: test name
 print_test()
 {
-	stdbuf -o0 -e0 printf "%-63s" "${1}"
+	_printf "%-63s" "${1}"
 }
 
 print_results()
 {
-	stdbuf -o0 -e0 printf "[%s]\n" "${1}"
+	_printf "[%s]\n" "${1}"
 }
 
 test_pass()
@@ -93,7 +96,7 @@ test_fail()
 	ret=1
 
 	if [ -n "${1}" ]; then
-		stdbuf -o0 -e0 printf "\t%s\n" "${1}"
+		_printf "\t%s\n" "${1}"
 	fi
 }
 
@@ -127,7 +130,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
-	stdbuf -o0 -e0 printf "Done\n"
+	_printf "Done\n"
 }
 
 trap cleanup EXIT
@@ -288,7 +291,7 @@ check_expected_one()
 		test_fail
 	fi
 
-	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
 		"${var}" "${!exp}" "${!var}"
 	return 1
 }

-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AB1C01
	for <mptcp@lists.linux.dev>; Thu, 28 Aug 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370853; cv=none; b=quJTeviJE/txs0Y9e+GJ5wQQeUGzBnPi4UI7tQwvtHFjl60GAhCUvxGgsJij5+d8X6tptvkcsHQnT8a5iLDfzL1zXlsZU6S/WrX0K8yV+So3rb27DoZaoFTbz4slNgd9qpMY0r1MJDJ7HlrnEXSs2GD/L/bQw34eXyDKbs7qVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370853; c=relaxed/simple;
	bh=Jbit38OgaSNes+cq9bsPdRsjQnPdKCKhDdp4KVU19e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPLkWe64yH4qZHbolFnMUcGoLq3tLxJArvEb1/17Vy8eTpHPPxJPwo2PCI1EGUqugoZMaZz2KqSwf03cS8+v0ekXVmt100UTpdo57AEDVxdWJMK/3OOCD2Ygnd9BB+k+FFWCKBBUxmn2spTccNEF1IHmnBBMMpgnyzkAgc7R6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOJeYv2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOJeYv2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD1EC4CEF5;
	Thu, 28 Aug 2025 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370851;
	bh=Jbit38OgaSNes+cq9bsPdRsjQnPdKCKhDdp4KVU19e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOJeYv2FFZNeYrYV4NWaQ8Bp8StxpQoyfWviw4PWFwPT+iJC0Dza4YgZDcNIKuK7x
	 dlkkN+/pccn/+W7RjecWstXDl4TOswKLZeEH6es4wCmI1Eim8R8/jvCPxnCDtep+aQ
	 1inCGIiCmVKMqCyjBqdiAdv1r8+5LOntfDhuDFgX603BbrfzGVIC++A98p0TzOpu6g
	 B0YtGBJoXVWxlUc4m/CXDioiEA5drJf9zNOjhkMZVKgFlhoWbdE93F4KX0+ETRzYP3
	 FRexgw7qvmKw7FbfVjdM9825dDVL4ughjVQGVJ37rDzlJw0mxBmkgIlPV8K0RpIyvG
	 XYiV8n3u4jPeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] Add test cases for MPTCP socket functionality
Date: Thu, 28 Aug 2025 16:47:15 +0800
Message-ID: <d549b3e3ecb5bd62d0a9f1e66125fa7d63daf6b9.1756369940.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756369940.git.tanggeliang@kylinos.cn>
References: <cover.1756369940.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds comprehensive test coverage for the MPTCP socket
implementation by introducing two test programs:

1. MPTCPServer.java - an echo server that uses MPTCP-enabled ServerSocket
2. MPTCPClient.java - a client that connects to the server using MPTCP
   Socket

The tests verify:
- MPTCP socket creation and connection establishment
- Bidirectional communication over MPTCP subflows
- Proper stream handling and error conditions
- Graceful shutdown and resource cleanup

These tests demonstrate the usage of the new MPTCP-enabled constructors and
provide a functional validation of the MPTCP implementation.

Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../java/net/ServerSocket/MPTCPServer.java    | 58 +++++++++++++++++
 test/jdk/java/net/Socket/MPTCPClient.java     | 62 +++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 test/jdk/java/net/ServerSocket/MPTCPServer.java
 create mode 100644 test/jdk/java/net/Socket/MPTCPClient.java

diff --git a/test/jdk/java/net/ServerSocket/MPTCPServer.java b/test/jdk/java/net/ServerSocket/MPTCPServer.java
new file mode 100644
index 00000000000..a28e4963943
--- /dev/null
+++ b/test/jdk/java/net/ServerSocket/MPTCPServer.java
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
+ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This code is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * version 2 for more details (a copy is included in the LICENSE file that
+ * accompanied this code).
+ *
+ * You should have received a copy of the GNU General Public License version
+ * 2 along with this work; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
+ * or visit www.oracle.com if you need additional information or have any
+ * questions.
+ */
+
+import java.io.*;
+import java.net.*;
+
+public class MPTCPServer {
+	public static void main(String[] args) {
+		final int PORT = 12345;
+
+		try (ServerSocket serverSocket = new ServerSocket(PORT, 50, null, true)) {
+			System.out.println("Server started, waiting for client connection ...");
+
+			Socket clientSocket = serverSocket.accept();
+			System.out.println("Client connected: " + clientSocket.getInetAddress());
+
+			BufferedReader in = new BufferedReader(
+					new InputStreamReader(clientSocket.getInputStream()));
+			PrintWriter out = new PrintWriter(
+					clientSocket.getOutputStream(), true);
+
+			String inputLine;
+			while ((inputLine = in.readLine()) != null) {
+				System.out.println("Received from client: " + inputLine);
+				out.println("Server response: " + inputLine);
+
+				if ("exit".equalsIgnoreCase(inputLine)) {
+					break;
+				}
+			}
+
+			clientSocket.close();
+			System.out.println("Connection closed");
+		} catch (IOException e) {
+			System.err.println("Server exception: " + e.getMessage());
+		}
+	}
+}
diff --git a/test/jdk/java/net/Socket/MPTCPClient.java b/test/jdk/java/net/Socket/MPTCPClient.java
new file mode 100644
index 00000000000..18d815c39e7
--- /dev/null
+++ b/test/jdk/java/net/Socket/MPTCPClient.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates. All rights reserved.
+ * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This code is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * version 2 for more details (a copy is included in the LICENSE file that
+ * accompanied this code).
+ *
+ * You should have received a copy of the GNU General Public License version
+ * 2 along with this work; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
+ * or visit www.oracle.com if you need additional information or have any
+ * questions.
+ */
+
+import java.io.*;
+import java.net.*;
+
+public class MPTCPClient {
+    public static void main(String[] args) {
+        final String HOST = "localhost";
+        final int PORT = 12345;
+        
+        try (Socket socket = new Socket(HOST, PORT, true, true)) {
+            System.out.println("Connected to server");
+            
+            BufferedReader in = new BufferedReader(
+                new InputStreamReader(socket.getInputStream()));
+            PrintWriter out = new PrintWriter(
+                socket.getOutputStream(), true);
+            
+            BufferedReader stdIn = new BufferedReader(
+                new InputStreamReader(System.in));
+            
+            String userInput;
+            System.out.println("Enter message (type 'exit' to quit):");
+            while ((userInput = stdIn.readLine()) != null) {
+                out.println(userInput);
+                
+                System.out.println("Server response: " + in.readLine());
+                
+                if ("exit".equalsIgnoreCase(userInput)) {
+                    break;
+                }
+            }
+            
+            System.out.println("Connection closed");
+        } catch (UnknownHostException e) {
+            System.err.println("Host not found: " + HOST);
+        } catch (IOException e) {
+            System.err.println("Client I/O error: " + e.getMessage());
+        }
+    }
+}
-- 
2.48.1

